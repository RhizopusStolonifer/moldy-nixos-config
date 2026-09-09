{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    font = "Kode Mono";
  };
}
