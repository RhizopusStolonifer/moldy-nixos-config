{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };
}
