{ config, lib, pkgs, ... }:

{
  imports = [
  #  ../../modules/configuration.nix
    ../../modules/system
    ../../modules/myco
    ./hardware-configuration.nix
    ./configuration.nix
    ./disko.nix
  ];
}
