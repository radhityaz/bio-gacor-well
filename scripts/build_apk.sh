#!/usr/bin/env bash
set -e

# 1) Pastikan Flutter binari versi 3.27.4 ada & PATH-nya benar
export FLUTTER_ROOT="$HOME/flutter"
export PATH="$FLUTTER_ROOT/bin:$PATH"

# 2) Hindari doctor (akses jaringan)
FLET_FLAGS=(build apk android --skip-flutter-doctor -v)

# 3) Monkey-patch kedua modul Flet yang mem-download SDK
python - <<'PY'
import os, sys, importlib
from packaging import version

# Path ke SDK pre-install (via flutter-action)
FLUTTER_ROOT = os.environ["FLUTTER_ROOT"]
FLET_CACHE = os.path.expanduser("~/.flet/flutter")
os.makedirs(FLET_CACHE, exist_ok=True)
open(os.path.join(FLET_CACHE, "version"), "w").write("3.27.4-stable")

# -- patch utils.flutter.install_flutter (Flet <=0.27.6)
utils_flutter = importlib.import_module("flet_cli.utils.flutter")

def _offline(*_, **__):
    return FLUTTER_ROOT

utils_flutter.install_flutter = _offline

# -- patch commands.build.install_flutter (redundant guard)
cmd_build = importlib.import_module("flet_cli.commands.build")
cmd_build.install_flutter = _offline
cmd_build.MINIMAL_FLUTTER_VERSION = version.Version("3.27.4")

# -- invoke Flet
import flet_cli.cli
sys.argv = ["flet"] + os.environ.get("FLET_ARGS", "").split()
if not sys.argv[1:]:
    sys.argv += ["build", "apk", "android", "--skip-flutter-doctor", "-v"]
flet_cli.cli.main()
PY

