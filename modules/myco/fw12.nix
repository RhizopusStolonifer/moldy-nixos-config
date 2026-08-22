{ config, lib, pkgs, inputs, ... }:

{
  imports = [ inputs.nix-doom-emacs-unstraightened.homeModule ];

  # doom emacs
  programs.doom-emacs = {
    enable = true;
    doomDir = ./doom;
    doomLocalDir = "~/.local/share/nix-doom";
    emacs = pkgs.emacs-pgtk;
  };
}
