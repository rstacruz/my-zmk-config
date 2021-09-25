#!/usr/bin/env bash
# Usage:
#    build.sh --board nice_nano_v2 --left microdox_left --right microdox_right
#
set -eou pipefail

main() {
  local board='' shield_left='' shield_right='' GID
  GID="$(id -g)"

  while true; do
    case "${1:-}" in
      --board) board="$2"; shift 2 ;;
      --left) shield_left="$2"; shift 2 ;;
      --right) shield_right="$2"; shift 2 ;;
      *) break ;;
    esac
  done

  if [[ -z "${board}${shield_left}${shield_right}" ]]; then
    echo 'Specify --board <board> --left <shield> --right <shield>'
    return 1
  fi

  rm -rf build/*.out

  docker run -it --rm \
    -v "$(pwd)/.cache:/keeb" \
    -v "$(pwd)/config:/keeb/config:ro" \
    -v "$(pwd)/build:/build" \
    zmkfirmware/zmk-build-arm:2.5 sh -c "
      cd /keeb

      if [ ! -d .west ]; then
        west init -l config
      fi

      if [ ! -d zmk ]; then
        west update
      fi

      west zephyr-export

      echo 'Building left'
      west build --pristine -b $board zmk/app -- \
        -DSHIELD=$shield_left \
        -DZMK_CONFIG=/keeb/config
      cp /keeb/build/zephyr/zmk.uf2 /build/${shield_left}_${board}.uf2.out
      chown $UID:$GID /build/${shield_left}_${board}.uf2.out

      echo 'Building right'
      west build --pristine -b $board zmk/app -- \
        -DSHIELD=$shield_right \
        -DZMK_CONFIG=/keeb/config
      cp /keeb/build/zephyr/zmk.uf2 /build/${shield_right}_${board}.uf2.out
      chown $UID:$GID /build/${shield_right}_${board}.uf2.out
    "

  if [[ ! -e "build/${shield_left}_${board}.uf2.out" ]] \
    || [[ ! -e "build/${shield_right}_${board}.uf2.out" ]]; then
    echo ''
    echo '-- Errors in building'
    exit 1
  fi

  echo ''
  echo '-- Done'
  rm -f build/${shield_left}_${board}.uf2 build/${shield_right}_${board}.uf2
  mv build/${shield_left}_${board}.uf2{.out,}
  mv build/${shield_right}_${board}.uf2{.out,}
  ls -la build/${shield_left}_${board}.uf2
  ls -la build/${shield_right}_${board}.uf2
}

main "$@"

# Thanks to https://git.lyte.dev/lytedev/keyboards/src/branch/master/zorne/build.fish
