#!/usr/bin/env bash
set -e

python - <<'PY'
import os, sys, importlib, pathlib, shutil
from packaging.version import Version

sdk = os.environ["FLUTTER_ROOT"]

# Ensure Flet cache points to the workflow Flutter SDK
cache_dir = pathlib.Path.home() / ".flet" / "flutter"
cache_dir.mkdir(parents=True, exist_ok=True)
link = cache_dir / "3.27.4-stable"
if link.exists() or link.is_symlink():
    if link.is_symlink() or link.is_file():
        link.unlink()
    else:
        shutil.rmtree(link)
link.symlink_to(sdk, target_is_directory=True)
(cache_dir / "version").write_text("3.27.4-stable")

# --- Patch both install_flutter functions so they never download ---
for mod_name in ("flet_cli.utils.flutter", "flet_cli.commands.build"):
    mod = importlib.import_module(mod_name)
    mod.install_flutter = lambda *_a, **_kw: sdk
    if hasattr(mod, "MINIMAL_FLUTTER_VERSION"):
        mod.MINIMAL_FLUTTER_VERSION = Version("3.27.4")

# --- Call Flet CLI (skip doctor to stay offline) ---
sys.argv = ["flet", "build", "apk", "android", "--skip-flutter-doctor", "-v"]
import flet_cli.cli; flet_cli.cli.main()
PY
