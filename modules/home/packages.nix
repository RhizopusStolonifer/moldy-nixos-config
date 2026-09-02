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
  ];
}
