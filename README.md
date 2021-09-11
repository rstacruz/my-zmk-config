# hmm

```sh
# install zephyr-sdk (archlinux aur)
# this installs west
yay zephyr-sdk

# creates .west/
west init -l config

# checks out zmk/ and zephyr/
west update

# Writes to ~/.cmake/packages/Zephyr
west zephyr-export

west build -s zmk/app -b nice_nano_v2 -- -DSHIELD=microdox_left -DZMK_CONFIG=(pwd)"/config"
```

## Docker

```sh
docker run --rm -it \
  zmkfirmware/zmk-build-arm:2.5 \
  /bin/bash
west init -l config
west update
west zephyr-export
```
