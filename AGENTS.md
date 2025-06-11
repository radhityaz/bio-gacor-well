# AGENT GUIDELINES

All tasks must ensure:

* **Linting** with `ruff .` shows no errors.
* **Testing** with `pytest -q` reaches ≥ 90% coverage.
* **Smoke Tests** run `scripts/smoke_test.sh` when present.
* Prefer small, focused commits per task.
* Document new modules with concise docstrings.
* When adding dependencies, pin versions in `requirements.txt` and update `pyproject.toml` if needed.
* Keep APK sizes under 60 MB for both debug and release builds.

These instructions apply to the entire repository unless overridden by nested `AGENTS.md` files.
