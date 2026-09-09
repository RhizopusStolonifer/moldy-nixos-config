{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
      ];
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  time.timeZone = "America/Vancouver";
}
