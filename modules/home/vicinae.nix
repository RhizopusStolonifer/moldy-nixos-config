{ inputs, pkgs, ... }:
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
        dark = {
          name = "dracula";
          icon_theme = "dracula-icons";
        };
      };

      launcher_window = {
        opacity = 0.5;
      };
    };

    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      # bluetooth
      nix
      wifi-commander
      niri
      gpu-screen-recorder
      vicinae-dms-extions
      process-manager
      fuzzy-files
      systemd
    ];
  };
}
