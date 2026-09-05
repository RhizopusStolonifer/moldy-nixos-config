{ pkgs, ... }:

{
  xdg.configFile."fcitx5/config".text = ''
    [Hotkey]
    TriggerKeys=
    EnumerateWith TriggerKeys=Hotkey

    [Hotkey/EnumerateWith]
    0=Super+k
  '';

  xdg.configFile."fcitx5/profile".text = ''
    [Groups/0]
    Name=Default
    Default Layout=us
    DefaultIM=keyboard-us

    [Groups/0/Items/0]
    Name=keyboard-us
    Layout=

    [Groups/0/Items/1]
    Name=mozc
    Layout=

    [GroupOrder]
    0=Default
  '';
}
