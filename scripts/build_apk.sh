#!/usr/bin/env bash
set -e

python - <<'PY'
import shutil, os, sys, importlib
from pathlib import Path
from packaging.version import Version

sdk = os.getenv("FLUTTER_ROOT") or os.getenv("FLUTTER_HOME")
if not sdk:
    bin_flutter = shutil.which("flutter")
    if not bin_flutter:
        sys.exit("\u274c  Flutter binary not found.")
    sdk = str(Path(bin_flutter).resolve().parents[1])

# patch utils.flutter & commands.build so Flet never downloads SDK
for module_name in ("flet_cli.utils.flutter", "flet_cli.commands.build"):
    m = importlib.import_module(module_name)
    m.install_flutter = lambda *_a, **_kw: sdk
    if hasattr(m, "MINIMAL_FLUTTER_VERSION"):
        m.MINIMAL_FLUTTER_VERSION = Version("3.27.4")

# call Flet CLI (skip doctor = no network)
sys.argv = ["flet", "build", "apk", "android", "--skip-flutter-doctor", "-v"]
import flet_cli.cli; flet_cli.cli.main()
PY
