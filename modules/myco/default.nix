{ config, lib, pkgs, ... }:

{
  imports = [
    ./zsh
    ./doom
    ./niri
    ./ghostty
  ];
}
