{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.teto-cursor;
    name = "teto";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
