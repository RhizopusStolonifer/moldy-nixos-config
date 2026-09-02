{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };
  systemd.user.services.niri.enableDefaultPath = false;

  xdg.portal = {
    enable = true;

    config = {
      common.default = [ "gtk" ];
    };
  };

  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
}
