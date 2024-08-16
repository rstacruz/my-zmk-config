docker = docker
docker_volumes = -v ./config:/root/config -v ./dist:/root/dist
docker_run = ${docker} run --rm ${docker_volumes} rstacruz/zmk-config

help:
	@echo "Usage:"
	@echo
	@grep -E '^[a-zA-Z_-].*?: .*?## .*$$' Makefile | sed 's#\\:#:#g' | awk 'BEGIN {FS = ": .*?## "}; {printf "\033[36m  %-20s\033[0m %s\n", $$1, $$2}'
	@echo

nerdctl:
	$(eval docker := nerdctl)
	@echo "Using 'nerdctl' instead of 'docker'"

prebuild:
	${docker} build . -t rstacruz/zmk-config
	mkdir -p dist

shell: prebuild
	${docker} run --rm -it ${docker_volumes} rstacruz/zmk-config bash

technikable: prebuild ## Build
	${docker_run} bash scripts/build_technikable

corne_left: prebuild ## Build
	${docker_run} bash scripts/build_corne left

corne_right: prebuild ## Build
	${docker_run} bash scripts/build_corne right

microdox_left: prebuild ## Build
	${docker_run} bash scripts/build_microdox left

microdox_right: prebuild ## Build
	${docker_run} bash scripts/build_corne right

flash_technikable: ## Flash
	bash scripts/flash --label TECHNIKABLE dist/technikable.uf2

flash_corne_left: ## Flash
	bash scripts/flash --label NICENANO dist/corne_left.uf2

flash_corne_right: ## Flash
	bash scripts/flash --label NICENANO dist/corne_right.uf2

flash_microdox_left: ## Flash
	bash scripts/flash --label NICENANO dist/microdox_left.uf2

flash_microdox_right: ## Flash
	bash scripts/flash --label NICENANO dist/microdox_right.uf2

clean: ## Remove built files
	rm -rf dist

prune: clean ## Remove Docker images
	docker rmi rstacruz/zmk-config

update: ## Update zmk
	docker build --pull --no-cache . -t rstacruz/zmk-config

