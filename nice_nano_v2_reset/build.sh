#!/usr/bin/env sh
set -xe

west build --pristine -b "nice_nano_v2" zmk/app -- -DZMK_CONFIG="$(pwd)/config" -DSHIELD="settings_reset"
cp build/zephyr/zmk.uf2 "nice_nano_v2_reset.uf2"
