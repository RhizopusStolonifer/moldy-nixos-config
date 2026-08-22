{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/configuration.nix
    ../../modules/system
    ./hardware-configuration.nix
    ./configuration.nix
    ./disko.nix
  ];
}
