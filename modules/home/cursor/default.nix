{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.miku-cursor-miku-coloured;
    name = "miku-coloured";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
