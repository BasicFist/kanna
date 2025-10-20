#!/usr/bin/env python3
"""Merge multiple conda environment exports into a single specification.

Usage:
    python tools/scripts/merge_conda_envs.py \
        --name ml-stack \
        --output config/environment-ml-stack.yml \
        tmp/env-exports/ml.json tmp/env-exports/ml-vllm.json tmp/env-exports/vllm.json

The script expects inputs produced by `conda env export --json`.
It keeps the highest Python minor version, prefers the newest dependency
versions where conflicts occur, and emits a YAML file with merged conda
and pip requirements. Conflicts that cannot be resolved automatically are
reported on stdout.
"""

from __future__ import annotations

import argparse
import json
from collections import OrderedDict, defaultdict
from pathlib import Path
from typing import Dict, Iterable, List, Mapping, MutableMapping, Set

from packaging.version import InvalidVersion, Version
import yaml


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Merge conda environment exports.")
    parser.add_argument(
        "inputs",
        nargs="+",
        type=Path,
        help="Paths to JSON exports produced by `conda env export --json`.",
    )
    parser.add_argument(
        "--name",
        default="merged-env",
        help="Name to use for the merged environment (default: merged-env).",
    )
    parser.add_argument(
        "--output",
        "-o",
        type=Path,
        default=Path("merged-environment.yml"),
        help="Where to write the merged YAML spec (default: merged-environment.yml).",
    )
    return parser.parse_args()


def _parse_version(value: str) -> Version | None:
    """Parse a version string, ignoring conda build metadata when present."""
    if not value:
        return None
    token = value
    for prefix in ("==", ">=", "<=", "~="):
        if value.startswith(prefix):
            token = value[len(prefix) :]
            break
    if "=" in token and prefix == "":
        # conda style e.g. 3.11.13=h9...
        token = token.split("=", 1)[0]
    if "+" in token and token.count("+") > 1:
        # keep the part before the second '+'
        token = token.split("+", 1)[0]
    token = token.strip()
    if not token:
        return None
    try:
        return Version(token)
    except InvalidVersion:
        return None


def _select_best(specs: Iterable[str]) -> str:
    """Choose the most appropriate version specifier from a collection."""
    specs = sorted(set(specs))
    if not specs:
        return ""

    def best_with_prefix(prefix: str, reverse: bool = True) -> str | None:
        candidates = [s for s in specs if s.startswith(prefix)]
        if not candidates:
            return None
        sorted_candidates = sorted(
            candidates,
            key=lambda s: _parse_version(s[len(prefix) :]) or Version("0"),
            reverse=reverse,
        )
        return sorted_candidates[0]

    for prefix in ("==", ">=", "<=", "~="):
        best = best_with_prefix(prefix, reverse=prefix != "<=")
        if best:
            return best

    # Fall back to plain versions (no prefix)
    parsed = sorted(
        ((spec, _parse_version(spec)) for spec in specs),
        key=lambda item: item[1] or Version("0"),
        reverse=True,
    )
    return parsed[0][0]


def _split_conda_dep(entry: str) -> tuple[str, str]:
    name, version, *_rest = entry.split("=", 2)
    return name, version


def merge_exports(paths: Iterable[Path]) -> Mapping[str, object]:
    channels: "OrderedDict[str, None]" = OrderedDict()
    conda_versions: MutableMapping[str, MutableMapping[str, Set[str]]] = defaultdict(
        lambda: defaultdict(set)
    )
    pip_versions: MutableMapping[str, MutableMapping[str, Set[str]]] = defaultdict(
        lambda: defaultdict(set)
    )

    conda_lower_names: Set[str] = set()

    for path in paths:
        data = json.loads(path.read_text())
        env_name = data.get("name", path.stem)
        for channel in data.get("channels", []):
            channels.setdefault(channel, None)
        for dep in data.get("dependencies", []):
            if isinstance(dep, str):
                name, version = _split_conda_dep(dep)
                conda_versions[name][env_name].add(version)
                conda_lower_names.add(name.lower())
            elif isinstance(dep, dict):
                for spec in dep.get("pip", []):
                    if spec.startswith("-r "):
                        continue
                    token = spec.strip()
                    if not token:
                        continue
                    for delimiter in ("==", ">=", "<=", "~=", " @ "):
                        if delimiter in token:
                            pkg, constraint = token.split(delimiter, 1)
                            spec_value = f"{delimiter}{constraint.strip()}"
                            break
                    else:
                        pkg, spec_value = token, ""
                    pip_versions[pkg.lower()][env_name].add(spec_value)
            else:
                raise TypeError(f"Unexpected dependency format: {dep!r}")

    merged_conda: List[str] = []
    merged_pip: List[str] = []
    conflict_messages: List[str] = []

    for name in sorted(conda_versions):
        specs_by_env = conda_versions[name]
        merged = _select_best(
            spec for versions in specs_by_env.values() for spec in versions
        )
        if len({tuple(sorted(vs)) for vs in specs_by_env.values()}) > 1:
            conflict_messages.append(
                f"Conda conflict for {name}: { {env: sorted(vs) for env, vs in specs_by_env.items()} } -> using {merged}"
            )
        merged_conda.append(f"{name}={merged}")

    pip_priority = {
        "pip": -2,
        "setuptools": -1,
        "wheel": 0,
        "torch": 10,
        "torchvision": 11,
        "torchaudio": 12,
        "flash-attn": 20,
    }
    pip_overrides = {
        "protobuf": "==5.29.5",
    }
    ordered_pip_names = [
        name
        for name in sorted(
            pip_versions,
            key=lambda name: (pip_priority.get(name, 1000), name),
        )
        if name not in conda_lower_names
    ]
    for pkg in ordered_pip_names:
        specs_by_env = pip_versions[pkg]
        merged = _select_best(
            spec for versions in specs_by_env.values() for spec in versions
        )
        if pkg in pip_overrides:
            merged = pip_overrides[pkg]
        if len({tuple(sorted(vs)) for vs in specs_by_env.values()}) > 1:
            conflict_messages.append(
                f"Pip conflict for {pkg}: { {env: sorted(vs) for env, vs in specs_by_env.items()} } -> using {pkg}{merged}"
            )
        merged_pip.append(f"{pkg}{merged}")

    merged_conda.insert(0, "pip")  # ensure pip is available for extras

    first_wave = {"pip", "setuptools", "wheel", "torch", "torchvision", "torchaudio"}
    pip_pass_one: List[str] = []
    pip_pass_two: List[str] = []
    for spec in merged_pip:
        normalized_name = spec.split("==")[0].split(">=")[0].split("<=")[0].split(" @ ")[0]
        (pip_pass_one if normalized_name in first_wave else pip_pass_two).append(spec)

    return {
        "channels": list(channels.keys()),
        "conda": merged_conda,
        "pip_pass_one": pip_pass_one,
        "pip_pass_two": pip_pass_two,
        "conflicts": conflict_messages,
    }


def build_yaml(env_name: str, merged: Mapping[str, object]) -> Mapping[str, object]:
    dependencies: List[object] = []
    dependencies.extend(sorted(merged["conda"]))
    if merged["pip_pass_one"]:
        dependencies.append({"pip": merged["pip_pass_one"]})
    if merged["pip_pass_two"]:
        dependencies.append({"pip": merged["pip_pass_two"]})
    return {"name": env_name, "channels": merged["channels"], "dependencies": dependencies}


def main() -> None:
    args = parse_args()
    merged = merge_exports(args.inputs)
    if merged["conflicts"]:
        print("Resolved conflicts:")
        for conflict in merged["conflicts"]:
            print(f"  - {conflict}")
    payload = build_yaml(args.name, merged)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(yaml.safe_dump(payload, sort_keys=False))
    print(f"Merged environment written to {args.output}")


if __name__ == "__main__":
    main()
