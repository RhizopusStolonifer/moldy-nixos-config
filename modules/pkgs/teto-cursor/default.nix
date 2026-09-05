{ stdenv }:
stdenv.mkDerivation {
  pname = "kasane-teto-cursor";
  version = "1.0";

  # Nix path literals can't contain spaces directly, so concatenate a path + string
  src = ../../home/cursor + "/Kasane Teto Cursor - by wobb/Linux/Kasane Teto";

  dontBuild = true;

  installPhase = ''
    mkdir -p "$out/share/icons/Kasane Teto"
    cp -r . "$out/share/icons/Kasane Teto/"
  '';
}
