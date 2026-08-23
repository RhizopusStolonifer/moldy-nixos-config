{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      trustedInterfaces = [
        config.services.tailscale.interfaceName
      ];
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
