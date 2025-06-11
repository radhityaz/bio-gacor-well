#!/usr/bin/env bash
set -e
# CI seeds Flutter and sets mirrors; skip doctor to avoid network
flet build apk android --skip-flutter-doctor
