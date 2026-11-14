{
  config,
  lib,
  pkgs,
  ...
}:

let
  py = pkgs.python3Packages;

  beets-vocadb = py.buildPythonPackage {
    pname = "beets-vocadb";
    version = "0-unstable-f958bba";
    pyproject = true;
    src = pkgs.fetchFromGitHub {
      owner = "prTopi";
      repo = "beets-vocadb";
      rev = "f958bba10a35380e4b926d6582bbf39cf31f0edd";
      hash = "sha256-PQ7XkL10PWR3UKZ3xoxjku2aT8XUtscF35BM4q04pcs=";
    };
    build-system = [ py.setuptools ];
    dontCheckRuntimeDeps = true;
    doCheck = false;
  };

  myBeets = py.beets.override {
    pluginOverrides = {
      vocadb = {
        enable = true;
        propagatedBuildInputs = [ beets-vocadb ];
      };
      utaitedb = {
        enable = true;
        propagatedBuildInputs = [ beets-vocadb ];
      };
      touhoudb = {
        enable = true;
        propagatedBuildInputs = [ beets-vocadb ];
      };
      bandcamp = {
        enable = true;
        propagatedBuildInputs = [ py.beetcamp ];
      };
    };
  };
in
{
  programs.beets = {
    enable = true;
    package = myBeets;
    settings = {
      directory = "/mnt/data/music/main_library/";

      include = [ "secrets.yaml" ];

      plugins = [
        # metadata sources
        "musicbrainz"
        "discogs"
        "vocadb"
        "utaitedb"
        "touhoudb"
        "bandcamp"

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

      vocadb = {
        prefer_romaji = false;
        search_limit = 5;
      };

      import.languages = [
        "jp"
        "en"
      ];

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
            name = "maybe.m3u";
            query = "^genres:Classical";
          }
        ];
      };
    };
  };

  home.packages = [ pkgs.chromaprint ];
}
