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

  services.syncthing = {
    enable = true;
    settings.gui.user = "myco";
    openDefaultPorts = true;
    guiAddress = "0.0.0.0:8384";
  };
}
