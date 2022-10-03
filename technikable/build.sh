#!/usr/bin/env sh
board="technikable"
set -x
set -e

if [ ! -d .west ]; then west init -l config; fi # creates .west/
if [ ! -d zmk ]; then west update; fi # creates zmk/ zephyr/ modules/
west zephyr-export # creates ~/.cmake/packages

west build --pristine -b "$board" zmk/app -- -DZMK_CONFIG="$(pwd)/config"
cp build/zephyr/zmk.uf2  /.dist/$board.uf2
chown $UID:$GID /.dist/$board.uf2
