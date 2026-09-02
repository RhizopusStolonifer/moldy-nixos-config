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
    };
  };

  time.timeZone = "America/Vancouver";
}
