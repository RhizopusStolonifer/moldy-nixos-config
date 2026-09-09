{ pkgs, ... }:
{
  programs.niri = {
    enable = true;
  };
  systemd.user.services.niri.enableDefaultPath = false;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    pkgs.labwc
    (pkgs.writeShellScriptBin "steam-labwc" ''
      exec ${pkgs.labwc}/bin/labwc -S steam
    '')
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    config = {
      common.default = [ "gtk" ];
    };
  };

  hardware.graphics.enable = true;
}
