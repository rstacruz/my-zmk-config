keeb := technikable
flash_file := technikable.uf2
docker_image := zmkfirmware/zmk-build-arm:stable
docker := docker
volume_label := TECHNIKABLE
base_path = $(shell pwd)
keeb_path = $(shell pwd)/${keeb}
docker_run = ${docker} run -it --rm \
	--name "zmk" \
	-v "${base_path}/.cache:/keeb" \
	-v "${keeb_path}:/keeb/config:ro" \
	-v "${base_path}/base36:/keeb/base36:ro" \
	-e HOST_UID="$(shell id -u)" \
	-e HOST_GID="$(shell id -g)" \
	"${docker_image}"

help:
	@echo "Usage: make {microdox|technikable} build"
	@echo
	@grep -E '^[a-zA-Z_-].*?: .*?## .*$$' Makefile | sed 's#\\:#:#g' | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m  %-20s\033[0m %s\n", $$1, $$2}'
	@echo

build: ## Builds [alias: b]
	${docker_run} sh -c "cd /keeb; bash /keeb/base36/west_setup.sh && bash /keeb/config/build.sh"
	cp .cache/*.uf2 . || true

sh: ## Opens a shell
	${docker_run} bash

update: ## Updates ZMK [alias: u]
	${docker_run} sh -c "cd /keeb; west update"

technikable:
	$(eval keeb := technikable)
	$(eval flash_file := technikable.uf2)
	$(eval volume_label := TECHNIKABLE)
	@true

microdox:
	$(eval keeb := microdox)
	$(eval flash_file := microdox_left.uf2)
	$(eval volume_label := NICENANO)
	@true

microdox_right: microdox
	$(eval flash_file := microdox_right.uf2)
	@true

chocofi:
	$(eval keeb := chocofi)
	$(eval flash_file := chocofi_left.uf2)
	$(eval volume_label := NICENANO)
	@true

nice_nano_v2_reset:
	$(eval keeb := nice_nano_v2_reset)
	$(eval flash_file := nice_nano_v2_reset.uf2)
	$(eval volume_label := NICENANO)
	@true

chocofi_right: chocofi
	$(eval flash_file := chocofi_right.uf2)
	@true

nerdctl:
	$(eval docker := nerdctl)
	@true

clean: ## Clean cache to update zmk/zephyr
	${docker} run -it --rm \
		-v "${base_path}/.cache:/keeb" \
		"${docker_image}" sh -c "rm -rf /keeb/*"

flash: ## Flash - only works for linux/macOS [alias: f]
	./flash.sh --label "${volume_label}" "./${flash_file}"

b: build
u: update
f: flash

.PHONY: microdox technikable chocofi nice_nano_v2_reset
