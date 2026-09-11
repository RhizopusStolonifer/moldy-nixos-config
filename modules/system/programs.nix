{ pkgs, inputs, ... }:
{
  programs = {
    zsh.enable = true;
  };
  programs.kdeconnect = {
    enable = true;
    package = pkgs.valent;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    fluxer-canary
    transmission_4-gtk
    icu
    openssl
    jdk
    maven
    wine-wayland
    python314Packages.beautifulsoup4 # for dms anime schedule widget
    brave
    lutris
    fzf
    fd
    librewolf
    protonup-qt
    proton-vpn-cli
    ani-cli
    gnused
    curl
    yt-dlp
    songrec
    python314Packages.libpulse
    fastfetch
    hyfetch
    pokeget-rs
    dracula-icon-theme
    p7zip
    picard
    songrec
    puddletag
    umu-launcher
    gpu-screen-recorder
    nix-search
    feishin
    supersonic
    libqalculate

    (python3.withPackages (
      python-pkgs: with python-pkgs; [
        numpy
        scipy
        sympy
        matplotlib
      ]
    ))

    (rWrapper.override {
      packages = with rPackages; [
        tidyverse
        languageserver
      ];
    })
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
