#!/bin/sh
# Regenerates icon/Tinland.icns from tools/dev/tinland_icon.tin (macOS with a GPU and iconutil).
# TIN_ROOT points at a tin checkout (default ../tin); its compiler is built from the checked-in seed when needed.
set -eu
cd "$(dirname "$0")/../.." || exit 1
tin_root=${TIN_ROOT:-../tin}
tin_root=$(cd "$tin_root" && pwd)
[ -x "$tin_root/bin/tinc" ] || make -s -C "$tin_root" bin/tinc
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT HUP INT TERM
mkdir "$tmp/Tinland.iconset"
"$tin_root/bin/tinc" -o "$tmp/icon" tools/dev/tinland_icon.tin
"$tmp/icon" "$tmp/Tinland.iconset"
iconutil -c icns "$tmp/Tinland.iconset" -o icon/Tinland.icns
echo "wrote icon/Tinland.icns"
