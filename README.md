# my zmk config

```sh
# installs west + zephyr SDK on arch linux
yay zephyr-sdk

# builds left and right
make
```

## Other commands

```sh
make -B  # force rebuild
make update # updates zmk/ and zephyr/
```

<!--

## Docker

```sh
docker run --rm -it \
  zmkfirmware/zmk-build-arm:2.5 \
  /bin/bash
west init -l config
west update
west zephyr-export
```
