#!/bin/bash
# Author: David M. Anderson
# Built with AI assistance (Claude, Anthropic)

set -euo pipefail
umask 022

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONTROL="$ROOT/packaging/control"
VER=$(awk '/^Version:/{print $2}' "$CONTROL")

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
chmod 0755 "$STAGE"

mkdir -p "$STAGE/DEBIAN" "$STAGE/usr/bin" "$STAGE/usr/share/doc/upd"
cp "$CONTROL" "$STAGE/DEBIAN/control"
install -m 0755 "$ROOT/upd" "$STAGE/usr/bin/upd"
install -m 0644 "$ROOT/LICENSE" "$STAGE/usr/share/doc/upd/copyright"
install -m 0644 "$ROOT/README.md" "$STAGE/usr/share/doc/upd/README.md"

OUT="/tmp/upd_${VER}_all.deb"
dpkg-deb --build --root-owner-group "$STAGE" "$OUT" >/dev/null
echo "$OUT"
