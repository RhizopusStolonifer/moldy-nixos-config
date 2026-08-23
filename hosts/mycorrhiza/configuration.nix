{ ... }:
{
  imports = [ ./default.nix ];

  networking.hostName = "mycorrhiza";

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;                 # recommended for Ampere/RTX 30-series
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = false; # laptop-hybrid concern mostly; leave off on desktop
  };
}
