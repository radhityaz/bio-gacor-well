#!/usr/bin/env bash
set -e

export PUB_HOSTED_URL="${PUB_HOSTED_URL:-https://pub.flutter-io.cn}"
export FLUTTER_STORAGE_BASE_URL="${FLUTTER_STORAGE_BASE_URL:-https://storage.flutter-io.cn}"

FLUTTER_SDK="$HOME/flutter"
flet build apk android --flutter-sdk "$FLUTTER_SDK"
