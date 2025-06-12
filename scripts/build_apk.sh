#!/usr/bin/env bash
set -e

python - <<'PY'
import os, sys, shutil, importlib
from pathlib import Path
from packaging.version import Version

# --- Tentukan lokasi SDK ---
sdk = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_HOME")
if not sdk:
    bin_flutter = shutil.which("flutter")
    if not bin_flutter:
        sys.exit("\u274c Flutter binary tidak ditemukan (env & PATH kosong).")
    sdk = str(Path(bin_flutter).resolve().parents[1])

# --- Patch Flet supaya tidak download ---
for mod_name in ("flet_cli.utils.flutter", "flet_cli.commands.build"):
    mod = importlib.import_module(mod_name)
    mod.install_flutter = lambda *_a, **_kw: sdk
    if hasattr(mod, "MINIMAL_FLUTTER_VERSION"):
        mod.MINIMAL_FLUTTER_VERSION = Version("3.27.4")

# --- Jalankan build offline ---
sys.argv = ["flet", "build", "apk", "android", "--skip-flutter-doctor", "-v"]
import flet_cli.cli; flet_cli.cli.main()
PY

