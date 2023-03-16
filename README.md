# my zmk config

Builds and flashes zmk firmware via Docker.

```sh
make build             # build technikable.uf2
make microdox build    # build microdox.uf2
```

![](./reference.png)

## Flashing

Copy the `.uf2` file to the keyboard in bootloader mode. Alternatively,

```bash
./flash.sh --label TECHNIKABLE technikable.uf2
./flash.sh --label NICENANO microdox_left.uf2
# only works on Linux and MacOS
```

## Acknowledgements

- [petejohanson/technikable-zmk-config](https://github.com/petejohanson/technikable-zmk-config) &mdash; board definitions for the Technikable were taken from here
