{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    xournalpp
    rnote
  ];

  xdg.configFile."xournalpp/palette.gpl".source = ./palette.gpl;
  xdg.configFile."xournalpp/toolbar.ini".source = ./toolbar.ini;
}
