#!/usr/bin/env bash
label="NICENANO"

flash-by-mount() {
  local device="$1"
  local file="$2"
  echo ""
  echo "-- Flashing $file"
  echo -n "-- Waiting for $device"
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

  echo -n "-- Sending $file..."
  cp "$file" /tmp/flashmnt
  sync
  umount -R /tmp/flashmnt
  echo ' ✓'
}

flash-by-cp() {
  local dest="$1"
  local file="$2"
  echo -n "-- Waiting for $dest"
  while true; do
    if [[ -e "$dest/CURRENT.UF2" ]]; then break; fi
    sleep 0.2
    echo -n '.'
  done
  echo ' ✓'

  echo -n "-- Sending $file..."
  cp "$file" "$dest/"
  # diskutil eject "$dest"
  echo ' ✓'
}

main() {
  local device='' file=''

  while true; do
    case "${1:-}" in
      --device) device="$2"; shift 2 ;;
      --file) file="$2"; shift 2 ;;
      *) break ;;
    esac
  done

  if [[ -z "${device}${file}" ]]; then
    echo 'Pass --device </dev/> --file <path/to/file.uf2>'
    exit 1
  fi

  if [[ -d /dev/disk/by-label ]]; then
    flash-by-mount "/dev/disk/by-label/$label" "$file"
  elif [[ -d /Volumes ]]; then
    flash-by-cp "/Volumes/$label" "$file"
  else
    echo '-- Sorry, your platform is unsupported'
    exit 1
  fi

  echo '-- Done!'
}

main "$@"
