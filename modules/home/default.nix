{ config, lib, pkgs, ... }:

{
  imports = [
    ./bat.nix
    ./browser.nix
    ./direnv.nix
    ./discord.nix
    ./eza.nix
    ./fastfetch/fastfetch.nix
    ./fzf.nix
    ./gaming.nix
    ./ghostty/ghostty.nix
    ./git.nix
    ./gtk.nix
    ./p10k/p10k.nix
    ./packages
    ./ssh.nix
    ./swaylock.nix
    ./xdg-mimes.nix
    ./zsh
  ];
}
