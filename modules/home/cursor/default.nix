{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.teto-cursor;
    name = "Kasane Teto";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
