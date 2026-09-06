{ stdenv, win2xcur }:
stdenv.mkDerivation {
  pname = "hatsune-miku-cursor-pink";
  version = "1.0";

  # the folder name still has parens, which Nix path literals can't contain unquoted —
  # same trick as the space issue: path + string concatenation
  src = ../../home/cursor + "/Hatsune_Miku_Cursor_(Version_2)_by_Wobb/Pink_Version";
  nativeBuildInputs = [ win2xcur ];
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    themeName="miku-pink"
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

    convert "Normal Select"         left_ptr default arrow top_left_arrow
    convert "Help Select"           help left_ptr_help question_arrow
    convert "Working in Background" progress left_ptr_watch half-busy
    convert "Busy"                  wait watch
    convert "Precision Select"      crosshair cross tcross
    convert "Text Select"           text xterm ibeam
    convert "Handwriting"           pencil
    convert "Unavailable"           not-allowed crossed_circle forbidden
    convert "Vertical Resize"       ns-resize size_ver sb_v_double_arrow v_double_arrow
    convert "Horizontal Resize"     ew-resize size_hor sb_h_double_arrow h_double_arrow
    convert "Diagonal Resize 1"     nwse-resize size_fdiag
    convert "Diagonal Resize 2"     nesw-resize size_bdiag
    convert "Move"                  move fleur size_all all-scroll
    convert "Alternate Select"      up-arrow
    convert "Link Select"           pointer hand2 hand1 pointing_hand
    # "Location Select" and "Person Select" have no standard X11 cursor name — skipped

    printf '[Icon Theme]\nName=%s\n' "$themeName" > "$themeDir/index.theme"
    cp "$themeDir/index.theme" "$themeDir/cursor.theme"
    runHook postInstall
  '';
}
