{ ... }:

{
  services.jellyfin = {
    enable = true;
    user = "myco";
  };

  services.navidrome = {
    enable = true;

    settings = {
      Address = "100.104.239.104";
      MusicFolder = "/mnt/data/music/";
    };
  };

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings.gui = {
      user = "myco";
      password = "@Cq8TNBGh&CFjVArNjP#";
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
    guiAddress = "0.0.0.0:8384";
  };
}
