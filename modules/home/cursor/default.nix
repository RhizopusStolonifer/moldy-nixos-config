{ pkgs, ... }:
{
  home.pointerCursor = {
    enable = true;
    name = "layan-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}
