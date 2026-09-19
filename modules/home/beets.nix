{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.beets = {
    enable = true;
    settings = {
      directory = "/mnt/data/music/main_library/";
      plugins = [
        "fetchart"
        "embedart"
        "scrub"
        "duplicates"
        "missing"
        "edit"
        "convert"
        "replaygain"
        "lastgenre"
        "chroma"
        "playlist"
        "smartplaylist"
      ];
      acoustid.apikey = "akEcyxTl3K";
      replaygain.backend = "ffmpeg";
      playlist = {
        auto = true;
        playlist_dir = "/mnt/data/music/_playlists";
        relative_to = "playlist";
      };
      smartplaylist = {
        auto = true;
        playlist_dir = "/mnt/data/music/_playlists";
        relative_to = "/mnt/data/music/_playlists";
        playlists = [
          {
            name = "Classical.m3u";
            query = "genres:Classical";
          }
          {
            name = "Vocaloid.m3u";
            query = "genres:Vocaloid";
          }
          {
            name = "Soundtrack.m3u";
            query = "genres:Soundtrack";
          }
          {
            name = "Anime.m3u";
            query = "genres:Anime";
          }
          {
            name = "Rock.m3u";
            query = "genres:Rock";
          }
          {
            name = "2010s.m3u";
            query = "year:2010..2019";
          }
          {
            name = "2020s.m3u";
            query = "year:2020..2029";
          }
        ];
      };
    };
  };

  home.packages = [ pkgs.chromaprint ];
}
