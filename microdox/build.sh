#!/usr/bin/env sh
board="microdox"
set -xe

if [ ! -d zmk ]; then west update; fi # creates zmk/ zephyr/ modules/
west zephyr-export # creates ~/.cmake/packages

# shield
west build --pristine -b "$board" zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/zephyr/zmk.uf2 "$board.uf2"
