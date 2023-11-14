#!/usr/bin/env sh
set -xe

west build -b "technikable" zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/zephyr/zmk.uf2 "technikable.uf2"
