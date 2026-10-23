{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.desktopManager.plasma6.enable = true;

  programs.hyprland = {
    enable = true;
    withUSM = true;
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "doom";
      clock = "%c";
    };
  };
  services.displayManager.defaultSession = "niri";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    khelpcenter
    konsole
  ];

  xdg.portal.config = {
    hyprland.default = [
      "hyprland"
      "gtk"
    ];
    KDE.default = [
      "kde"
      "gtk"
    ];
  };
}
