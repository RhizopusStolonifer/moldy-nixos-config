{ stdenv }:
stdenv.mkDerivation {
  pname = "kasane-teto-cursor";
  version = "1.0";

  # Nix path literals can't contain spaces directly, so concatenate a path + string
  src = ../../home/cursor + "/Kasane_Teto_Cursor_by_wobb/Linux/Kasane_Teto";

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/share/icons/teto"
    cp -r . "$out/share/icons/teto/"
  '';
}
