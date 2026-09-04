{ ... }:

{
  services.jellyfin = {
    enable = true;
    user = "myco";
  };

  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/mnt/data/music/";
    };
  };
}
