# Repository Guidelines

## Project Structure & Module Organization
- Core analysis lives in `analysis/python/{cheminformatics|ml-models|text-mining}` and `analysis/r-scripts/{ethnobotany|statistics|meta-analysis}`; notebooks go in `analysis/jupyter-notebooks` and are stripped before commit via `nbstripout`.
- Research data is grouped under `data/` by discipline (ethnobotanical, phytochemical, clinical, legal, molecular-modeling); sensitive raw interviews and patient files stay in git-ignored subdirectories.
- Writing assets sit in `writing/thesis-chapters/ch0x-*` with publication-ready outputs under `assets/{figures|tables}`; collaboration records and ethics materials reside in `collaboration/`.

## Build, Test, and Development Commands
- Create or refresh the Python environment with `python -m venv venv && source venv/bin/activate && pip install -r requirements.txt`; conda users must install RDKit separately (`conda install -c conda-forge rdkit`).
- Install R dependencies by running `Rscript analysis/r-scripts/install-packages.R`; re-run after adding new R packages.
- Preferred quick checks: `python -c "import pandas, numpy"` for Python readiness, `Rscript -e "library(tidyverse)"` for R, and `jupyter lab` for notebook sessions.

## Coding Style & Naming Conventions
- Python code follows PEP 8 enforced by `black analysis/python/` and `ruff check analysis/python/ --fix`; reserve type hints for public functions and keep modules under 500 lines.
- R scripts adopt tidyverse style (pipe-friendly verbs, snake_case objects); keep reproducible chunks in `.R` scripts and narrative exploration in notebooks.
- File names use project patterns (`INT-YYYYMMDD-Community-Participant.txt`, `CHEM-YYYYMMDD-Batch-Compound.csv`); keep outputs de-identified and store heavy binaries in Git LFS when needed.

## Testing Guidelines
- Add `pytest` suites beside Python modules (e.g., `analysis/python/ml-models/tests/test_qsar.py`) covering data validation, model training edges, and serialization.
- For R workflows, include smoke tests or reproducible examples in `analysis/r-scripts/tests/` using `testthat`, and document required seed values for stochastic models.
- Execute `pytest` before pushing Python updates and `Rscript -e "testthat::test_dir('analysis/r-scripts/tests')"` before merging R changes; attach coverage notes for major pipelines.

## Commit & Pull Request Guidelines
- Use semantic prefixes observed in history (`feat:`, `fix:`, `docs:`, `data:`, `refactor:`) followed by a concise, imperative summary under 72 characters.
- Each PR should describe scope, list affected directories, link related issues or research trackers, and attach validation evidence (command outputs, figures, or screenshots).
- Update status docs (`PROJECT-STATUS.md`, `OPTIMIZED-THESIS-WORKFLOW.md`) when relevant, note FPIC considerations for data additions, and ensure notebooks remain output-free before requesting review.
