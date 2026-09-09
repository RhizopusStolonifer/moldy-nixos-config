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
        light = lib.mkForce {
          name = "vicinae-light";
          icon_theme = "default";
        };
        dark = lib.mkForce {
          name = "dracula";
          icon_theme = "dracula-icons";
        };
        font = {
          normal = {
            family = "Kode Mono";
          };
        };
      };

      launcher_window = {
        opacity = lib.mkForce 1;
        compact_mode.enabled = true;
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
