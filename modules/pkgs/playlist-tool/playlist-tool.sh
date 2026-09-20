PLAYLIST_DIR="/mnt/data/music/_playlists"
mkdir -p "$PLAYLIST_DIR"

usage() {
	cat <<'EOF'
Usage:
  playlist-tool add <name>
  playlist-tool add <name> <query...>
  playlist-tool rm <name>
  playlist-tool rm <name> <query...>
  playlist-tool ls

<query...> e.g.:
  genres:Classical
  artist:Bach
  genres:Classical artist+       sorted by artist
  genres:Classical artist+ genre+  ...then by genre
EOF
}

interactive_add() {
	local name="$1" file="$2"

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

	local abspath relpath added=0
	while IFS=$'\t' read -r _ _ _ _ _ _ abspath; do
		[[ -z "$abspath" ]] && continue
		relpath=$(realpath --relative-to="$PLAYLIST_DIR" "$abspath")
		if ! grep -qxF "$relpath" "$file"; then
			printf '%s\n' "$relpath" >>"$file"
			added=$((added + 1))
		fi
	done <<<"$selected"

	echo "Added $added track(s) to $file"
}

bulk_add() {
	local name="$1" file="$2"
	shift 2

	local abspath relpath added=0
	while IFS= read -r abspath; do
		[[ -z "$abspath" ]] && continue
		relpath=$(realpath --relative-to="$PLAYLIST_DIR" "$abspath")
		if ! grep -qxF "$relpath" "$file"; then
			printf '%s\n' "$relpath" >>"$file"
			added=$((added + 1))
		fi
	done < <(beet ls -f '$path' "$@")

	echo "Added $added track(s) to $file (name: $name)"
}

cmd_add() {
	local name="$1"
	shift
	local file="$PLAYLIST_DIR/$name.m3u"

	if [[ ! -f "$file" ]]; then
		printf '#EXTM3U\n' >"$file"
	fi

	if [[ $# -gt 0 ]]; then
		bulk_add "$name" "$file" "$@"
	else
		interactive_add "$name" "$file"
	fi
}

interactive_rm() {
	local name="$1" file="$2"

	local mapping
	mapping=$(
		grep -v '^#' "$file" | while IFS= read -r rel; do
			[[ -z "$rel" ]] && continue
			abspath=$(realpath -m "$PLAYLIST_DIR/$rel")
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

bulk_rm() {
	local name="$1" file="$2"
	shift 2

	local matches
	matches=$(beet ls -f '$path' "$@")
	if [[ -z "$matches" ]]; then
		echo "No matching tracks."
		return 0
	fi

	local -A match_set
	local p
	while IFS= read -r p; do
		[[ -z "$p" ]] && continue
		match_set["$(realpath -m "$p")"]=1
	done <<<"$matches"

	local tmp rel abspath removed=0
	tmp=$(mktemp)
	while IFS= read -r rel; do
		if [[ "$rel" == \#* || -z "$rel" ]]; then
			printf '%s\n' "$rel" >>"$tmp"
			continue
		fi
		abspath=$(realpath -m "$PLAYLIST_DIR/$rel")
		if [[ -n "${match_set[$abspath]:-}" ]]; then
			removed=$((removed + 1))
		else
			printf '%s\n' "$rel" >>"$tmp"
		fi
	done <"$file"
	mv "$tmp" "$file"

	echo "Removed $removed track(s) from $file (name: $name)"
}

cmd_rm() {
	local name="$1"
	shift
	local file="$PLAYLIST_DIR/$name.m3u"

	if [[ ! -f "$file" ]]; then
		echo "No such playlist: $name" >&2
		return 1
	fi

	if [[ $# -gt 0 ]]; then
		bulk_rm "$name" "$file" "$@"
	else
		interactive_rm "$name" "$file"
	fi
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
		local name="$2"
		shift 2
		cmd_add "$name" "$@"
		;;
	rm)
		if [[ -z "${2:-}" ]]; then
			usage
			exit 1
		fi
		local name="$2"
		shift 2
		cmd_rm "$name" "$@"
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
