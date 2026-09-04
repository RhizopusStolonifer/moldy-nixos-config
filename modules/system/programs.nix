{ pkgs, inputs, ... }:
{
  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    fluxer-canary
    transmission_4-gtk
    icu
    openssl
    python3
    jdk
    maven
    wine-wayland
    python314Packages.beautifulsoup4 # for dms anime schedule widget
    brave
    lutris
    fzf
    fd
    librewolf

    (python3.withPackages (
      python-pkgs: with python-pkgs; [

      ]
    ))
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
