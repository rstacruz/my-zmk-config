#!/usr/bin/env sh
set -xe

west build --pristine -b "nice_nano_v2" zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_left"
cp build/zephyr/zmk.uf2 "chocofi_left.uf2"

west build --pristine -b "nice_nano_v2" zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_right"
cp build/zephyr/zmk.uf2 "chocofi_right.uf2"
