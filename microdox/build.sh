#!/usr/bin/env sh
set -xe

west build -b "nice_nano_v2" -d build/microdox_left zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="microdox_left"
cp build/microdox_left/zephyr/zmk.uf2 "microdox_left.uf2"

west build -b "nice_nano_v2" -d build/microdox_right zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="microdox_right"
cp build/microdox_right/zephyr/zmk.uf2 "microdox_right.uf2"
