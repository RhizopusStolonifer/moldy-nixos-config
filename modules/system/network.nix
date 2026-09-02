{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
      8384
      ];
      allowedUDPPorts = [
      
      ];
    };
  };

  time.timeZone = "America/Vancouver";
}
