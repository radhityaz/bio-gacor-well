#!/usr/bin/env bash
set -e

# Use existing Flutter SDK if present to avoid redundant downloads
FLUTTER_VERSION="3.27.4"
FLUTTER_DIR="$HOME/flutter/$FLUTTER_VERSION"
if [ -x "$FLUTTER_DIR/bin/flutter" ]; then
  export PATH="$FLUTTER_DIR/bin:$PATH"
fi

flet build apk android
