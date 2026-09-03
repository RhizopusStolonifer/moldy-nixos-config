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
    jdk8
    maven
    wine-wayland
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
