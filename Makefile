keeb := technikable
docker_image := zmkfirmware/zmk-build-arm:stable

help:
	@echo "make build; make {microdox|technikable} build"

build:
	docker run -it --rm \
		--name "zmk-${keeb}" \
		-v "$(shell pwd)/.cache:/keeb" \
		-v "$(shell pwd)/${keeb}:/keeb/config:ro" \
		-v "$(shell pwd)/base36:/keeb/base36:ro" \
		-e HOST_UID="$(shell id -u)" \
		-e HOST_GID="$(shell id -g)" \
		"${docker_image}" sh -c "cd /keeb; sh config/build.sh"

	cp .cache/*.uf2 . || true

technikable:
	$(eval keeb := technikable)
	@true

microdox:
	$(eval keeb := microdox)
	@true

clean:
	docker run -it --rm \
		-v "$(shell pwd)/.cache:/keeb" \
		"${docker_image}" sh -c "rm -rf /keeb/*"
