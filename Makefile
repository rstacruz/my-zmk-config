build:
	docker buildx build -t zmk .
	docker run --rm -it --name zmk \
		-v $(PWD)/config:/app/config:ro \
		-e KEEB=technikable \
		zmk
