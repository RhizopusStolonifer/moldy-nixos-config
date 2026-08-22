{ config, lib, pkgs, ... }:

{
  imports = [ inputs.niri.homeModules.niri ];
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${config.programs.niri.package}/bin/niri-session";
      user = "myco";
    };
  };
}
