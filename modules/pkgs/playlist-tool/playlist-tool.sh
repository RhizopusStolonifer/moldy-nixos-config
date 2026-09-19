PLAYLIST_DIR="/mnt/data/music/_playlists"
mkdir -p "$PLAYLIST_DIR"

usage() {
  cat <<'EOF'
Usage:
  playlist-tool add <name>   Fuzzy-pick tracks to add to a playlist (creates it if new)
  playlist-tool rm <name>    Fuzzy-pick tracks to remove from a playlist
  playlist-tool ls           List existing playlists
EOF
}

cmd_add() {
  local name="$1"
  local file="$PLAYLIST_DIR/$name.m3u"

  if [[ ! -f "$file" ]]; then
    printf '#EXTM3U\n' >"$file"
  fi

  local selected
  selected=$(
    beet ls -f $'$id\t$artist\t$album\t$title\t$genres\t$year\t$path' |
      fzf --multi --delimiter=$'\t' --with-nth=2,3,4,5,6 \
        --header="TAB to select multiple, ENTER to confirm" \
        --prompt="add to ${name}> "
  )

  if [[ -z "$selected" ]]; then
    echo "Nothing selected."
    return 0
  fi

  local abspath relpath
  while IFS=$'\t' read -r _ _ _ _ _ _ abspath; do
    [[ -z "$abspath" ]] && continue
    relpath=$(realpath --relative-to="$PLAYLIST_DIR" "$abspath")
    if ! grep -qxF "$relpath" "$file"; then
      printf '%s\n' "$relpath" >>"$file"
    fi
  done <<<"$selected"

  echo "Updated $file"
}

cmd_rm() {
  local name="$1"
  local file="$PLAYLIST_DIR/$name.m3u"

  if [[ ! -f "$file" ]]; then
    echo "No such playlist: $name" >&2
    return 1
  fi

  local mapping
  mapping=$(
    grep -v '^#' "$file" | while IFS= read -r rel; do
      [[ -z "$rel" ]] && continue
      abspath=$(realpath -m "$PLAYLIST_DIR/$rel")
      # shellcheck disable=SC2016 # single-quoted: this is beets' own template syntax, not bash expansion
      label=$(beet ls -f '$artist - $title' path:"$abspath" 2>/dev/null || true)
      if [[ -z "$label" ]]; then
        label="$rel"
      fi
      printf '%s\t%s\n' "$label" "$rel"
    done
  )

  if [[ -z "$mapping" ]]; then
    echo "Playlist is empty."
    return 0
  fi

  local to_remove
  to_remove=$(
    printf '%s\n' "$mapping" |
      fzf --multi --delimiter=$'\t' --with-nth=1 \
        --header="remove from ${name}, TAB to select multiple" |
      cut -f2
  )

  if [[ -z "$to_remove" ]]; then
    echo "Nothing selected."
    return 0
  fi

  local tmp
  tmp=$(mktemp)
  grep -vFxf <(printf '%s\n' "$to_remove") "$file" >"$tmp"
  mv "$tmp" "$file"
  echo "Removed track(s) from $file"
}

cmd_ls() {
  find "$PLAYLIST_DIR" -maxdepth 1 -name '*.m3u' -printf '%f\n' 2>/dev/null | sed 's/\.m3u$//'
}

main() {
  local cmd="${1:-}"
  case "$cmd" in
    add)
      if [[ -z "${2:-}" ]]; then
        usage
        exit 1
      fi
      cmd_add "$2"
      ;;
    rm)
      if [[ -z "${2:-}" ]]; then
        usage
        exit 1
      fi
      cmd_rm "$2"
      ;;
    ls)
      cmd_ls
      ;;
    *)
      usage
      exit 1
      ;;
  esac
}

main "$@"
