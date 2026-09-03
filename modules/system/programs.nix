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

    (python3.withPackages (ps: with ps; [
      beatifulsoup4 # for dms anime schedule widget
    ]))
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
