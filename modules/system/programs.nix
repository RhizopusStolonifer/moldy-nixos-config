{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
  };

  environment.systemPackages = with pkgs; [
    smartmontools
    fluxer-canary
  ];

  nixpkgs.overlays = [ inputs.fluxer.overlays.default ];
}
