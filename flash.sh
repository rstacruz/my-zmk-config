#!/usr/bin/env bash
# examples:
#
#   flash.sh --label TECHNIKABLE technikable.uf2
#   flash.sh --label NICENANO microdox_left.uf2
#
main() {
  local label='NICENANO' file=''

  while true; do
    case "${1:-}" in
      --label) label="$2"; shift 2 ;;
      *) break ;;
    esac
  done

  file="$1"

  if [[ -z "${file}" ]]; then
    echo 'Usage: flash.sh [--label LABEL] path/to/file.uf2'
    exit 1
  fi

  if [[ -d /mnt/wsl ]]; then
    # WSL
    # flash-by-cp "/mnt/e" "$file"
    echo '-- Sorry, no WSL support yet :('
    exit 1
  elif [[ -d /dev/disk/by-label ]]; then
    # Linux
    flash-by-mount "/dev/disk/by-label/$label" "$file"
  elif [[ -d /Volumes ]]; then
    # MacOS
    flash-by-cp "/Volumes/$label" "$file"
  else
    echo '-- Sorry, your platform is unsupported'
    exit 1
  fi

  echo '-- Done!'
}

# flash-by-mount "/dev/disk/by-label/NICENANO" "file.uf2"
flash-by-mount() {
  local device="$1"
  local file="$2"
  echo ""
  echo "━━› Flashing $file"
  echo -n "━━› Waiting for $device"
  while true; do
    if [[ -e "$device" ]]; then break; fi
    sleep 0.2
    echo -n '.'
  done
  echo ' ✓'
  echo -n '-- Mounting...'
  mkdir -p /tmp/flashmnt
  mount "$device" /tmp/flashmnt
  echo ' ✓'

  echo -n "━━› Sending $file..."
  cp "$file" /tmp/flashmnt
  sync
  umount -R /tmp/flashmnt
  echo ' ✓'
}

# flash-by-cp "/Volumes/NICENANO" "file.uf2"
flash-by-cp() {
  local dest="$1"
  local file="$2"
  echo -n "━━› Waiting for $dest"
  while true; do
    if [[ -e "$dest/CURRENT.UF2" ]]; then break; fi
    sleep 0.2
    echo -n '.'
  done
  echo ' ✓'

  echo -n "━━› Sending $file..."
  cp "$file" "$dest/"
  echo ' ✓'
}

main "$@"
