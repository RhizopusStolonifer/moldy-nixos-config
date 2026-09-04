{
  config,
  lib,
  pkgs,
  ...
}:

{
  security = {
    sudo-rs.enable = true;

    pam.services = {
      swaylock.enableGnomeKeyring = true;
    };
  };
}
