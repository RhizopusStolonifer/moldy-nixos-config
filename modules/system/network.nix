{
  pkgs,
  host,
  config,
  ...
}:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [
      ];
      allowedUDPPorts = [
        config.services.tailscale.port
      ];
      trustedInterfaces = [
        "tailscale0"
        config.services.tailscale.interfaceName
      ];
    };
  };

  time.timeZone = "America/Vancouver";

  services.tailscale.enable = true;
  networking.nftables.enable = true;
  systemd.services.tailscaled.serviceConfig.Environment = [ "TS_DEBUG_FIREWALL_MODE=nftables" ];
}
