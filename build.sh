#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "==> Building Rlux..."
swift build -c release

echo "==> Creating app bundle..."
APP_DIR="build/Rlux.app/Contents"
rm -rf build/Rlux.app
mkdir -p "$APP_DIR/MacOS"
mkdir -p "$APP_DIR/Resources"

cp .build/release/Rlux "$APP_DIR/MacOS/Rlux"
cp Resources/Info.plist "$APP_DIR/Info.plist"

echo "==> Signing (ad-hoc)..."
codesign --force --sign - "build/Rlux.app"

echo ""
echo "Done! App bundle created at: build/Rlux.app"
echo ""
echo "To install:  cp -r build/Rlux.app /Applications/"
echo "To run:      open build/Rlux.app"
