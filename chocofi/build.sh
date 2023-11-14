#!/usr/bin/env sh
set -xe

west build -b "nice_nano_v2" -d build/chocofi_left zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_left nice_view_adapter nice_view"
cp build/chocofi_left/zephyr/zmk.uf2 "chocofi_left.uf2"

west build -b "nice_nano_v2" -d build/chocofi_right zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_right nice_view_adapter nice_view"
cp build/chocofi_right/zephyr/zmk.uf2 "chocofi_right.uf2"
