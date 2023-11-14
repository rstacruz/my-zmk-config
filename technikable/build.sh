#!/usr/bin/env sh
board="technikable"
set -xe

if [ ! -d .west ]; then west init -l config; fi # creates .west/

if [ ! -d zmk ]; then west update; fi # creates zmk/ zephyr/ modules/

west status
west zephyr-export # creates ~/.cmake/packages

# --pristine
west build -b "$board" zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/zephyr/zmk.uf2 "$board.uf2"
