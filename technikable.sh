#!/usr/bin/env sh
docker run -it --rm \
  -v "$(pwd)/.cache:/keeb" \
  -v "$(pwd)/technikable:/keeb/config:ro" \
  -e HOST_UID="$UID" \
  -e HOST_GID="$GID" \
  "zmkfirmware/zmk-build-arm:stable" sh -c "cd /keeb; sh config/build.sh"
  # -v "$(pwd)/technikable/boards:/keeb/boards:ro" \
