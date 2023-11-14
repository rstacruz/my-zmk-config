#!/usr/bin/env sh
set -xe

west build -b "technikable" -d build/technikable zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/technikable/zephyr/zmk.uf2 "technikable.uf2"
