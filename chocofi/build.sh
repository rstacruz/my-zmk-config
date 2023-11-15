#!/usr/bin/env sh
set -xe

if [[ "${1:-}" == "chocofi_right" ]]; then
	west build -b "nice_nano_v2" -d build/chocofi_right zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_right nice_view_adapter nice_view"
	cp build/chocofi_right/zephyr/zmk.uf2 "chocofi_right.uf2"
else
	west build -b "nice_nano_v2" -d build/chocofi_left zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="corne_left nice_view_adapter nice_view"
	cp build/chocofi_left/zephyr/zmk.uf2 "chocofi_left.uf2"
fi
