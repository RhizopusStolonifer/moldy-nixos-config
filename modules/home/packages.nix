{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # utilities
    eza
    fd
    ripgrep
    gtrash
    tldr
    mpv
    ffmpeg
    unzip
    wget
    wl-clipboard
    xdg-utils
    winetricks
    
    nixd

    pavucontrol
    obs-studio
    vlc

    libreoffice
    vesktop

    prismlauncher

    # emacs
    gcc
    cmake libtool
    sqlite
    universal-ctags
    aspell aspellDicts.en
    languatetool
    pyright
    bash-language-server shellcheck shfmt
    vccode-langservers-extracted
    marksman
    lua-language-server
    texlab texliveMedium
    ledger
    (rWrapper.override { packages = with rPackages; [ languageserver ]; })
  ];

  services.syncthing = {
    enable = true;
    settings.gui.user = "myco";
    guiAddress = "0.0.0.0:8384";
  };
}
