{ stdenv, win2xcur }:
stdenv.mkDerivation {
  pname = "adachi-rei-cursor";
  version = "1.0";

  src = ../../home/cursor;
  nativeBuildInputs = [ win2xcur ];
  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    src="$src/Quick-Adachi Rei Cursor/Adachi Rei Cursor"
    themeName="adachi-rei"
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

    convert "Normal"      left_ptr default arrow top_left_arrow
    convert "Help"        help left_ptr_help question_arrow
    convert "Working"     progress left_ptr_watch half-busy
    convert "Busy"        wait watch
    convert "Precision"   crosshair cross tcross
    convert "Text"        text xterm ibeam
    convert "Handwriting" pencil
    convert "Unavailable" not-allowed crossed_circle forbidden
    convert "Vertical"    ns-resize size_ver sb_v_double_arrow v_double_arrow
    convert "Horizontal"  ew-resize size_hor sb_h_double_arrow h_double_arrow
    convert "Diagonal1"   nwse-resize size_fdiag
    convert "Diagonal2"   nesw-resize size_bdiag
    convert "Move"        move fleur size_all all-scroll
    convert "Alternate"   up-arrow
    convert "Link"        pointer hand2 hand1 pointing_hand

    printf '[Icon Theme]\nName=%s\n' "$themeName" > "$themeDir/index.theme"
    cp "$themeDir/index.theme" "$themeDir/cursor.theme"
    runHook postInstall
  '';
}
