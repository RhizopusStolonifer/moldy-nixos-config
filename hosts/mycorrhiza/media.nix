{ ... }:

{
  services.jellyfin = {
    enable = true;
  };

  services.navidrome = {
    enable = true;

    settings = {
      MusicFolder = "/mnt/data/music/";
    };
  };
}
