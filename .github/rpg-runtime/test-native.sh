#!/usr/bin/env bash
set -euo pipefail
root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
cd "$root"
make -C libretro -j4 platform=unix >/dev/null
test -s build/bin/sameduck_libretro.so
nm -D build/bin/sameduck_libretro.so | grep -q ' retro_serialize$'
nm -D build/bin/sameduck_libretro.so | grep -q ' retro_unserialize$'
