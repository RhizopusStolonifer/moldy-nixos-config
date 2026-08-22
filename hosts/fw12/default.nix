{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/configuration.nix
    ../../modules/myco
    ./hardware-configuration.nix
    ./configuration.nix
    ./disko.nix
  ];
}
