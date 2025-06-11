#!/usr/bin/env bash
set -e

# Mirror fallback
export PUB_HOSTED_URL="${PUB_HOSTED_URL:-https://pub.flutter-io.cn}"
export FLUTTER_STORAGE_BASE_URL="${FLUTTER_STORAGE_BASE_URL:-https://storage.flutter-io.cn}"

python - <<'PY'
import sys
from packaging import version
import flet_cli.commands.build as build

# Monkey-patch minimal Flutter version
build.MINIMAL_FLUTTER_VERSION = version.Version("3.22.1")

# Invoke Flet CLI build
import flet_cli.cli
sys.argv = ["flet", "build", "apk", "android"]
flet_cli.cli.main()
PY
