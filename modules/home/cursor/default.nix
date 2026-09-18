{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    package = pkgs.adachi-rei-cursor;
    name = "Adachi Rei Cursor";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
