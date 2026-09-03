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
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
