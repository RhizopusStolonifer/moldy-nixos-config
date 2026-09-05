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
      ignoreUserConfig = true;

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
            "DefaultIM" = "keyboard-us"; # Forces English as the group default
          };
          "Groups/0/Items/0" = {
            "Name" = "keyboard-us";
          };
          "Groups/0/Items/1" = {
            "Name" = "mozc";
          };
        };

        globalOptions = {
          "Behavior" = {
            # False = Start in inactive mode (pure US keyboard layout)
            "ActiveByDefault" = "False";
            # Reset input method state to default when switching focused windows
            "resetStateWhenFocusIn" = "All";
          };
          "Hotkey" = {
            "TriggerKeys" = "";
          };
          "Hotkey/TriggerKeys" = {
            "0" = "Control+space";
          };
        };
      };
    };
  };
}
