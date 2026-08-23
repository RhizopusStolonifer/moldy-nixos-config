{ config, lib, pkgs, ... }:

{
  imports = [
    ./bootloader.nix
    ./bluetooth.nix
    ./fonts.nix
    ./network.nix
    ./nh.nix
    ./nixpkgs.nix
    ./pipewire.nix
    ./program.nix
    ./security.nix
    ./services.nix
    ./steam.nix
    ./system.nix
    ./user.nix
    ./wayland.nix
    ./xserver.nix
  ];
}
