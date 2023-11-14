#!/usr/bin/env sh
# Sets up west

if [ ! -d .west ]; then west init -l config; fi # creates .west/

if [ ! -d zmk ]; then west update; fi # creates zmk/ zephyr/ modules/

west status
west zephyr-export # creates ~/.cmake/packages
