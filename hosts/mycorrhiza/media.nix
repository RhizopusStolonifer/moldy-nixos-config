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
    settings.gui = {
      user = "myco";
      password = "@Cq8TNBGh&CFjVArNjP#";
      devices = {
        "fw12" = {
          id = "AGEUHWX-52MKJMH-IYGYVQY-DYXMIWD-WMIBMST-5WZB4H7-FTJ4K22-HU67CQH";
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
