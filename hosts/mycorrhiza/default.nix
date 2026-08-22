{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ./configuration.nix
    ../../modules/common.nix
    ../../modules/system
    ../../modules/myco
  ];


}
