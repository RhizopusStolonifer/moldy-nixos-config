{ pkgs, inputs, ... }:
{
  imports = [ inputs.niri.nixosModules.niri ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  zramSwap.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  users.users.myco = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";   # run passwd myco on reinstall
  };

  environment.systemPackages = with pkgs; [ git vim nh ];
  # nh
  programs.nh = {
    enable = true;
    flake = "/etc/nixos";
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
  };
  services.openssh.enable = true;
  programs.zsh.enable = true;
  services.tailscale.enable = true;
  services.syncthing = { enable = true; user = "myco"; };
  programs.steam.enable = true;


  system.stateVersion = "26.05";

}
