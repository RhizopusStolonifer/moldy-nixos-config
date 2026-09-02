{ ... }:
{
  imports = [
    ./nh.nix
    ./user.nix
    ./bootloader.nix
    ./network.nix
    ./fonts.nix
    ./programs.nix
    ./nixpkgs.nix
    ./wayland.nix
    ./steam.nix
    ./pipewire.nix
  ];
}
