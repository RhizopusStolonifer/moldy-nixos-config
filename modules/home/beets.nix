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
      ];
      acoustid.apikey = "akEcyxTl3K";
      replaygain.backend = "ffmpeg";
    };
  };

  home.packages = [ pkgs.chromaprint ];
}
