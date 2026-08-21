{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./disko.nix
    ../../modules/common.nix
  ];

  networking.hostName = "mycorrhiza";
}
