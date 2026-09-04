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
      library = "/home/myco/.config/beets/library.db";
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
    };

    package = pkgs.beets.override {
      pluginOverrides = {
        filetote = {
          enable = true;
          propagatedBuildInputs = [ pkgs.beetsPackages.filetote ];
        };
      };
    };
  };

  home.packages = [ pkgs.chromaprint ];
}
