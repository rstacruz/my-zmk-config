#!/usr/bin/env sh
docker run -it --rm \
  -v "$(pwd)/.cache:/keeb" \
  -v "$(pwd)/.dist:/dist" \
  -v "$(pwd)/technikable:/keeb/config:ro" \
  "zmkfirmware/zmk-build-arm:stable" sh -c "cd /keeb; sh config/build.sh"
