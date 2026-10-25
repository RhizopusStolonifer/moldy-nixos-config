{
  pkgs,
  config,
  inputs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ../../modules/system
    ./media.nix
    inputs.disko.nixosModules.disko
    ./disko.nix
    inputs.nixos-hardware.nixosModules.framework-16-7040-amd
  ];

  environment.systemPackages = with pkgs; [
    #acpi
    brightnessctl
    cpupower-gui
    powertop
  ];

  services = {
    power-profiles-daemon.enable = true;
    upower = {
      enable = true;
      percentageLow = 15;
      percentageCritical = 5;
      percentageAction = 3;
    };
  };

  boot = {
    #kernelModules = [ "acpi_call" ];
    extraModulePackages =
      with config.boot.kernelPackages;
      [
        #acpi_call
        cpupower
      ]
      ++ [ pkgs.cpupower-gui ];
  };
}
