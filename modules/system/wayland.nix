{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };
  systemd.user.services.niri.enableDefaultPath = false;

  environment.systemPackages = with pkgs; [ xwayland-satellite ];
  xdg.portal = {
    enable = true;

    config = {
      common.default = [ "gtk" ];
    };
  };

  hardware.graphics.enable = true;
}
