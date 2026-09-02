{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkManager.enable = true;

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
