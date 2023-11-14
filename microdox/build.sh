#!/usr/bin/env sh
board="nice_nano_v2"
shield_l="microdox_left"
shield_r="microdox_right"
set -xe

west build --pristine -b "$board" zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="$shield_l"
cp build/zephyr/zmk.uf2 "$shield_l.uf2"

west build --pristine -b "$board" zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="$shield_r"
cp build/zephyr/zmk.uf2 "$shield_r.uf2"
