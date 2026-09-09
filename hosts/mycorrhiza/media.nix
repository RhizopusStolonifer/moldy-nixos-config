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
}
