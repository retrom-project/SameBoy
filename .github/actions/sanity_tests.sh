#!/usr/bin/env bash
set -euo pipefail

# Max Pirate's Mega Duck build is MIT licensed. Pin its source commit and bytes.
test -x build/bin/tester/sameduck_tester
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
curl -fsSL --retry 3 \
  https://raw.githubusercontent.com/bbbbbr/MaxPirate_megaduck/742b498e08c1eafae5fc4fb8b5cd481288f11c1f/build/duck/MaxPirate.duck \
  -o "$work/maxpirate.duck"
printf '%s  %s\n' 3ae8119cd892eaa4685a7a45393046da658dd90dbe990be0eec8260072caca06 "$work/maxpirate.duck" |
  shasum -a 256 -c -

cp "$work/maxpirate.duck" "$work/title.duck"
cp "$work/maxpirate.duck" "$work/started.duck"
build/bin/tester/sameduck_tester --length 10 "$work/title.duck"
build/bin/tester/sameduck_tester --start --length 10 "$work/started.duck"
printf '%s  %s\n' eee28da7f37d5f331f61700df3d74a6b4b059cb1f92dfc410e63d5129b183eed "$work/title.bmp" |
  shasum -a 256 -c -
printf '%s  %s\n' a0fbcda87ffc0270db73a9332c4413834d306fd10c66373cd88317562cb8fa0d "$work/started.bmp" |
  shasum -a 256 -c -
