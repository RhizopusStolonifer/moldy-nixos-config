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
    withUWSM = true;
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "dur_file";
      dur_file_path = "${../../Wallpapers/blackhole-smooth-240x67.dur}";
      full_color = true;
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

  boot = {
    plymouth = {
      enable = true;
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };
}
