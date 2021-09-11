PWD = $(shell pwd)

# zmk config
shield_left = microdox_left
shield_right = microdox_right
board = nice_nano_v2

# output files
left_file = microdox_left.uf2
right_file = microdox_right.uf2

default: build

init: .west zmk

.west:
	@# creates .west/config
	west init -l config || true

zmk:
	@# checks out zmk/ and zephyr/, then writes to ~/.cmake/packages/Zephyr
	west update && west zephyr-export

update: ## Forces an update of zmk/ and zephyr/
	@make -B init

build: init ${left_file} ${right_file} ## Builds .uf2 files

${left_file}: $(wildcard config/*)
	west build -s zmk/app -b ${board} -- -DSHIELD=${shield_left} -DZMK_CONFIG=${PWD}/config
	rm -f "${left_file}"
	cp build/zephyr/zmk.uf2 "${left_file}"

${right_file}: $(wildcard config/*)
	west build --pristine -s zmk/app -b ${board} -- -DSHIELD=${shield_right} -DZMK_CONFIG=${PWD}/config
	rm -f "${right_file}"
	cp build/zephyr/zmk.uf2 "${right_file}"

clean:
	rm -rf zmk zephyr build modules tools .west

.PHONY: init build clean
