{ config, lib, pkgs, ... }:

{
  imports = [ inputs.nix-doom-emacs-unstraightened.homeModule inputs.niri.nixosModules.niri ];

  # doom emacs
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom;
    doomLocalDir = "~/.local/share/nix-doom";
    emacs = pkgs.emacs-pgtk;
  };
}
