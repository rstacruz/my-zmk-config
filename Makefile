PWD = $(shell pwd)

# zmk config
shield_l := microdox_left
shield_r := microdox_right
board := nice_nano_v2

# output files
file_l = build/${shield_l}_${board}.uf2
file_r = build/${shield_r}_${board}.uf2

# where to flash
device = /dev/disk/by-label/NICENANO

default:
	@echo
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-].*?: .*?## .*$$' Makefile | sed 's#\\:#:#g' | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m  %-20s\033[0m %s\n", $$1, $$2}'
	@echo

technikable:
	$(eval shield_l := technikable)
	$(eval shield_r := $(shell echo))
	$(eval board := technikable)
	@true

build: build-left ## Build the firmware [alias: build-left, bl]
build-left: ${file_l} ## Build the firmware, left [alias: b]
build-right: ${file_l} ## Build the firmware, right

flash-left: ${file_l} ## Flash left [alias: l]
	@sudo bash flash.sh --file ${file_l}

flash-right: ${file_r} ## Flash right [alias: r]
	@sudo bash flash.sh --file ${file_r}

clean: ## Clean cache to rebuild from scratch
	docker image rm zmkfirmware/zmk-build-arm:stable || true
	sudo rm -rf .cache build/*.uf2

${file_l}: config/*
	bash build.sh --board ${board} --left ${shield_l}

${file_r}: config/*
	bash build.sh --board ${board} --left ${shield_l} --right ${shield_r}

b: build
l: flash-left
r: flash-right

.PHONY: build b clean c flash-left l flash-right r
