#!/usr/bin/env sh
set -xe

west build -b "nice_nano_v2" -d build/nice_nano_v2_reset zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="settings_reset"
cp build/nice_nano_v2_reset/zephyr/zmk.uf2 "nice_nano_v2_reset.uf2"
