{ config, lib, pkgs, ... }:

{
  imports = [
    ./zsh/zsh.nix
    ./niri/niri.nix
    ./ghostty/ghostty.nix
  ];
}
