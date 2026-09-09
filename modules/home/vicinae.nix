{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.vicinae.homeManagerModules.default ];

  programs.vicinae = {
    enable = true;
    systemd.enable = true;

    settings = {
      close_on_focus_loss = true;
      theme = {
        light = {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = lib.mkForce {
          name = "dracula";
          icon_theme = "dracula-icons";
        };
      };

      launcher_window = {
        opacity = lib.mkForce 0.5;
      };
    };

    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      # bluetooth
      nix
      wifi-commander
      niri
      gpu-screen-recorder
      #dms  # doesn't work??
      process-manager
      fuzzy-files
    ];
  };
}
