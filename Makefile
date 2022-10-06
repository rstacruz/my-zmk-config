keeb := technikable
docker_image := zmkfirmware/zmk-build-arm:stable
volume_label := TECHNIKABLE
base_path = $(shell pwd)
keeb_path = $(shell pwd)/${keeb}

help:
	@echo "Usage: make {microdox|technikable} build"
	@echo
	@grep -E '^[a-zA-Z_-].*?: .*?## .*$$' Makefile | sed 's#\\:#:#g' | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m  %-20s\033[0m %s\n", $$1, $$2}'
	@echo

build: ## Builds [alias: b]
	docker run -it --rm \
		--name "zmk-${keeb}" \
		-v "${base_path}/.cache:/keeb" \
		-v "${keeb_path}:/keeb/config:ro" \
		-v "${base_path}/base36:/keeb/base36:ro" \
		-e HOST_UID="$(shell id -u)" \
		-e HOST_GID="$(shell id -g)" \
		"${docker_image}" sh -c "cd /keeb; sh config/build.sh"

	cp .cache/*.uf2 . || true

technikable:
	$(eval keeb := technikable)
	$(eval volume_label := TECHNIKABLE)
	@true

microdox:
	$(eval keeb := microdox)
	$(eval volume_label := NICENANO)
	@true

clean: ## Clean cache to update zmk/zephyr
	docker run -it --rm \
		-v "${base_path}/.cache:/keeb" \
		"${docker_image}" sh -c "rm -rf /keeb/*"

b: build
