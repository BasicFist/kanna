#!/usr/bin/env python3
"""
Generate the literature manifest and bibliographic exports for the KANNA thesis.

This script scans the curated PDF corpus in ``literature/pdfs/BIBLIOGRAPHIE/``,
collects metadata via ``pdfinfo``, aligns each paper with the existing chapter
staging, and produces three deliverables:

1. ``manifest.csv`` – canonical inventory with chapter assignments.
2. ``kanna.ris`` – RIS import file for Zotero (links back to local PDFs).
3. ``kanna.bib`` – BibTeX file mirroring the RIS content (fallback when Zotero
   export is not yet configured).

The script is intentionally deterministic (sorted output, stable citekeys) so
that re-running it is safe.
"""

from __future__ import annotations

import csv
import os
import re
import subprocess
from collections import Counter
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Sequence, Set, Tuple

PROJECT_ROOT = Path(__file__).resolve().parents[2]
BIBLIO_DIR = PROJECT_ROOT / "literature" / "pdfs" / "BIBLIOGRAPHIE"
STAGING_DIR = PROJECT_ROOT / "literature" / "zotero-import-staging"
EXPORT_DIR = PROJECT_ROOT / "literature" / "zotero-export"
MANIFEST_PATH = BIBLIO_DIR / "manifest.csv"
RIS_PATH = EXPORT_DIR / "kanna.ris"
BIB_PATH = EXPORT_DIR / "kanna.bib"

CHAPTER_LABELS = {
    0: "general",
    1: "introduction",
    2: "botany",
    3: "ethnobotany",
    4: "pharmacology",
    5: "clinical",
    6: "addiction",
    7: "legal-ethics",
    8: "synthesis",
}


@dataclass
class PaperRecord:
    filename: str
    title: str
    authors: List[str]
    year: Optional[int]
    chapter: int
    pages: Optional[int]
    file_size_kb: Optional[int]
    creation_date: Optional[str]
    modification_date: Optional[str]

    @property
    def chapter_label(self) -> str:
        return CHAPTER_LABELS.get(self.chapter, "general")

    @property
    def citekey(self) -> str:
        """Generate a stable citekey (authorYear[_suffix])."""
        base = ""
        if self.authors:
            first_author = self.authors[0]
            parts = re.split(r"[,\s]+", first_author.strip())
            if parts:
                base = parts[-1].lower()
        if not base:
            base = re.sub(r"[^a-z0-9]+", "", self.filename.split()[0].lower())

        year_part = str(self.year) if self.year else "nd"
        return f"{base}{year_part}"


def ensure_dependencies() -> None:
    if not shutil_which("pdfinfo"):
        raise RuntimeError(
            "pdfinfo command not found. Install poppler-utils or ensure pdfinfo is on PATH."
        )


def shutil_which(cmd: str) -> Optional[str]:
    """Local wrapper to avoid importing shutil at module import time."""
    from shutil import which

    return which(cmd)


def load_chapter_assignments() -> Dict[str, int]:
    """Use existing chapter folders as canonical mapping."""
    assignments: Dict[str, int] = {}
    if not STAGING_DIR.exists():
        return assignments

    for chapter_dir in STAGING_DIR.glob("chapter-*"):
        try:
            chapter_num = int(chapter_dir.name.split("-")[1])
        except (IndexError, ValueError):
            continue
        for pdf in chapter_dir.glob("*.pdf"):
            assignments[pdf.name] = chapter_num
    return assignments


def discover_pdfs() -> List[Path]:
    if not BIBLIO_DIR.exists():
        raise RuntimeError(f"Expected PDF directory not found: {BIBLIO_DIR}")
    return sorted(BIBLIO_DIR.glob("*.pdf"))


def parse_pdfinfo(pdf_path: Path) -> Dict[str, str]:
    result = subprocess.run(
        ["pdfinfo", str(pdf_path)],
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        return {}
    info: Dict[str, str] = {}
    for line in result.stdout.splitlines():
        if ":" not in line:
            continue
        key, value = line.split(":", 1)
        info[key.strip()] = value.strip()
    return info


def parse_authors(author_raw: str) -> List[str]:
    if not author_raw or author_raw.lower() in {"anonymous", "unknown"}:
        return []

    cleaned = author_raw.strip()
    cleaned = cleaned.replace("\u2022", " ")
    cleaned = cleaned.replace(" • ", " ")
    separators = [";", "|", "\n"]
    for sep in separators:
        if sep in cleaned:
            return [a.strip() for a in cleaned.split(sep) if a.strip()]

    if " and " in cleaned:
        return [a.strip() for a in cleaned.split(" and ") if a.strip()]

    if " & " in cleaned:
        return [a.strip() for a in cleaned.split(" & ") if a.strip()]

    # Handle patterns like "Surname, Firstname; Surname, Firstname"
    if cleaned.count(";") >= 1:
        return [a.strip() for a in cleaned.split(";") if a.strip()]

    # If there are multiple commas and most segments have spaces, treat comma as separator.
    comma_segments = [seg.strip() for seg in cleaned.split(",") if seg.strip()]
    if len(comma_segments) >= 3:
        merged: List[str] = []
        buffer = ""
        for segment in comma_segments:
            if buffer:
                merged.append(f"{buffer}, {segment}".strip())
                buffer = ""
            else:
                if len(segment.split()) == 1:
                    buffer = segment
                else:
                    merged.append(segment)
        if buffer:
            merged.append(buffer)
        if merged:
            return merged

    return [cleaned]


def guess_year(filename: str, creation_date: Optional[str]) -> Optional[int]:
    match = re.match(r"(\d{4})", filename)
    if match:
        return int(match.group(1))
    if creation_date:
        for fmt in ("%a %b %d %H:%M:%S %Y", "%Y-%m-%dT%H:%M:%S"):
            try:
                return datetime.strptime(creation_date[:19], fmt).year
            except ValueError:
                continue
        if len(creation_date) >= 4 and creation_date[:4].isdigit():
            return int(creation_date[:4])
    return None


def build_records() -> List[PaperRecord]:
    assignments = load_chapter_assignments()
    records: List[PaperRecord] = []

    for pdf_path in discover_pdfs():
        info = parse_pdfinfo(pdf_path)
        title = info.get("Title") or pdf_path.stem
        authors_raw = info.get("Author", "")
        authors = parse_authors(authors_raw)
        creation = info.get("CreationDate")
        modification = info.get("ModDate")
        pages = int(info["Pages"]) if "Pages" in info else None
        size_kb = pdf_path.stat().st_size // 1024
        year = guess_year(pdf_path.name, creation)
        chapter = assignments.get(pdf_path.name, 0)

        record = PaperRecord(
            filename=pdf_path.name,
            title=title,
            authors=authors,
            year=year,
            chapter=chapter,
            pages=pages,
            file_size_kb=size_kb,
            creation_date=creation,
            modification_date=modification,
        )
        records.append(record)

    records.sort(key=lambda r: (r.year or 0, r.title.lower()))
    return records


def write_manifest(records: Sequence[PaperRecord]) -> None:
    fieldnames = [
        "filename",
        "title",
        "authors",
        "year",
        "chapter",
        "chapter_label",
        "pages",
        "file_size_kb",
        "creation_date",
        "modification_date",
    ]
    BIBLIO_DIR.mkdir(parents=True, exist_ok=True)
    with MANIFEST_PATH.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.DictWriter(fh, fieldnames=fieldnames)
        writer.writeheader()
        for record in records:
            writer.writerow(
                {
                    "filename": record.filename,
                    "title": record.title,
                    "authors": "; ".join(record.authors),
                    "year": record.year or "",
                    "chapter": record.chapter,
                    "chapter_label": record.chapter_label,
                    "pages": record.pages or "",
                    "file_size_kb": record.file_size_kb or "",
                    "creation_date": record.creation_date or "",
                    "modification_date": record.modification_date or "",
                }
            )


def escape_bib(value: str) -> str:
    return (
        value.replace("\\", "\\\\")
        .replace("{", "\\{")
        .replace("}", "\\}")
        .replace("\"", '\\"')
    )


def write_bibtex(records: Sequence[PaperRecord]) -> None:
    EXPORT_DIR.mkdir(parents=True, exist_ok=True)
    citekey_counts: Counter[str] = Counter()

    lines: List[str] = [
        "% Auto-generated by analysis/python/generate_literature_manifest.py",
        "% Source: literature/pdfs/BIBLIOGRAPHIE",
    ]

    for record in records:
        base_key = record.citekey
        citekey_counts[base_key] += 1
        suffix = "" if citekey_counts[base_key] == 1 else chr(ord("a") + citekey_counts[base_key] - 2)
        citekey = f"{base_key}{suffix}"

        authors_bib = " and ".join(record.authors) if record.authors else ""
        year_field = str(record.year) if record.year else ""
        file_field = BIBLIO_DIR / record.filename

        entry_lines = [
            f"@article{{{citekey},",
            f"  title = {{{escape_bib(record.title)}}},",
        ]
        if authors_bib:
            entry_lines.append(f"  author = {{{escape_bib(authors_bib)}}},")
        if year_field:
            entry_lines.append(f"  year = {{{year_field}}},")
        entry_lines.append(f"  note = {{{record.chapter_label}}},")
        entry_lines.append(f"  file = {{{escape_bib(str(file_field))}}},")
        entry_lines.append("}")
        lines.extend(entry_lines)
        lines.append("")

    with BIB_PATH.open("w", encoding="utf-8") as fh:
        fh.write("\n".join(lines).rstrip() + "\n")


def write_ris(records: Sequence[PaperRecord]) -> None:
    EXPORT_DIR.mkdir(parents=True, exist_ok=True)
    lines: List[str] = [
        "TY  - JOUR",
        "TI  - KANNA Placeholder Record",
        "ER  - ",
        "",
    ]  # Start with placeholder to keep Zotero happy on empty import.
    lines.clear()  # Remove placeholder to keep file clean; maintained in case of future logic.

    for idx, record in enumerate(records, start=1):
        lines.append("TY  - JOUR")
        lines.append(f"TI  - {record.title}")
        for author in record.authors:
            lines.append(f"AU  - {author}")
        if record.year:
            lines.append(f"PY  - {record.year}")
        lines.append(f"N1  - Chapter {record.chapter}: {record.chapter_label}")
        file_path = BIBLIO_DIR / record.filename
        lines.append(f"L1  - {file_path}")
        lines.append(f"ID  - {record.citekey}")
        lines.append("ER  - ")
        lines.append("")

    with RIS_PATH.open("w", encoding="utf-8") as fh:
        fh.write("\n".join(lines).rstrip() + "\n")


def main() -> None:
    ensure_dependencies()
    records = build_records()
    write_manifest(records)
    write_ris(records)
    write_bibtex(records)
    print(f"✓ Manifest written to {MANIFEST_PATH}")
    print(f"✓ RIS export written to {RIS_PATH}")
    print(f"✓ BibTeX export written to {BIB_PATH}")


if __name__ == "__main__":
    main()
