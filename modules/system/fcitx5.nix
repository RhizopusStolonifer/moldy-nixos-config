{
  config,
  lib,
  pkgs,
  ...
}:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true; # Ignore local changes in ~/.config/fcitx5

      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        qt6Packages.fcitx5-configtool
      ];

      settings = {
        inputMethod = {
          "GroupOrder" = {
            "0" = "Default";
          };
          "Groups/0" = {
            "Name" = "Default";
            "Default Layout" = "us";
            "DefaultIM" = "keyboard-us";
          };
          "Groups/0/Items/0" = {
            "Name" = "keyboard-us";
            "Layout" = "";
          };
          "Groups/0/Items/1" = {
            "Name" = "mozc";
            "Layout" = "";
          };
        };

        globalOptions = {
          "Hotkey" = {
            "TriggerKeys" = "";
            #"EnumerateForwardKeys" = "Control+Alt+k";
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+space";
          };
          "Behavior" = {
            "ActiveByDefault" = "True";
          };
        };
      };
    };
  };
}
