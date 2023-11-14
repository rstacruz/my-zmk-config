#!/usr/bin/env bash
set -eou pipefail

west build -s zmk/app -b technikable zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/zephyr/zmk.uf2 ./technikable.uf2
