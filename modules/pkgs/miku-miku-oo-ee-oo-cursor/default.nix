{ stdenv, win2xcur }:
stdenv.mkDerivation {
  pname = "miku-miku-oo-ee-oo-cursor";
  version = "1.0";

  src = ../../home/cursor/miku-miku-oo-ee-oo;
  nativeBuildInputs = [ win2xcur ];
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    themeName="miku-miku-oo-ee-oo"
    themeDir="$out/share/icons/$themeName"
    mkdir -p "$themeDir/cursors"
    cd "$themeDir/cursors"

    convert() {
      local winFile="$1"; shift
      local names=("$@")
      win2xcur "$src/$winFile.cur" -o . 2>/dev/null \
        || win2xcur "$src/$winFile.ani" -o . 2>/dev/null \
        || { echo "warning: could not convert '$winFile'" >&2; return; }
      mv -- "$winFile" "''${names[0]}"
      for n in "''${names[@]:1}"; do ln -sf "''${names[0]}" "$n"; done
    }

    convert "Normal"                left_ptr default arrow top_left_arrow
    convert "Help_32-48-64"         help left_ptr_help question_arrow
    convert "Wait_32-48-64"         progress left_ptr_watch half-busy wait watch
    convert "context-menu_32-48-64" text xterm ibeam
    convert "hand_32-48-64"         pointer hand2 hand1 pointing_hand
    convert "Move"                  move fleur size_all all-scroll
    convert "NotAllowed"            not-allowed crossed_circle forbidden

    convert "EWResize"          ew-resize size_hor sb_h_double_arrow h_double_arrow
    convert "NSResize"          ns-resize size_ver sb_v_double_arrow v_double_arrow
    convert "copy_32-48-64"     copy dnd-copy
    convert "alias_32-48-64"    alias
    convert "Link_32-48-64"     dnd-link
    convert "dnd-ask_32-48-64"  dnd-ask
    convert "zoom-in_32-48-64"  zoom-in
    convert "zoom-out_32-48-64" zoom-out

    printf '[Icon Theme]\nName=%s\n' "$themeName" > "$themeDir/index.theme"
    cp "$themeDir/index.theme" "$themeDir/cursor.theme"
    runHook postInstall
  '';
}
