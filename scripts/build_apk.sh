#!/usr/bin/env bash
set -e

python3 - <<'PY'
import pathlib
import sys

flutter_version = "3.27.4"
version_file = pathlib.Path.home() / ".flet" / "flutter" / "version"
version_file.parent.mkdir(parents=True, exist_ok=True)
version_file.write_text(flutter_version)

try:
    import flet.cli.commands.build as build_mod
    def install_flutter(*args, **kwargs):
        print("Skipping install_flutter (offline)")
    if hasattr(build_mod, "install_flutter"):
        build_mod.install_flutter = install_flutter
except Exception as e:
    print("install_flutter patch failed:", e)

from flet.cli import cli
# Build APK from current directory
sys.argv = ["flet", "build", "apk", "."]
cli.main()
PY

