{ config, pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    user = "myco";
  };

  services.navidrome = {
    enable = true;

    plugins = with pkgs.navidromePlugins; [
      # discord-rich-presence
      listenbrainz-daily-playlist
    ];

    settings = {
      Address = "100.104.239.104";
      MusicFolder = "/mnt/data/music/";
    };
  };

  # Navidrome binds to the Tailscale IP, so it must not start until
  # tailscaled has brought the interface up (After=network.target alone
  # isn't enough and caused boot-time bind failures).
  systemd.services.navidrome = {
    after = [ "tailscaled.service" ];
    wants = [ "tailscaled.service" ];
    serviceConfig = {
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
    user = "myco";
    group = "users";
    guiPasswordFile = config.sops.secrets.syncthing_gui_password.path;
    settings = {
      gui = {
        user = "myco";
      };
      devices = {
        "fw12" = {
          id = "S72GWPX-PKQVE7Z-R4DABGN-CX2IUSG-DZSZ5X5-BXCLIXN-X7H7RQQ-ZRLLIAN";
        };
      };
      folders = {
        "sync" = {
          path = "/home/myco/sync";
          devices = [ "fw12" ];
        };
      };
    };
  };
}
