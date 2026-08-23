{ inputs, ... }:
{
  programs.niri.config = builtins.readFile ./config.kdl;

  xdg.configFile."niri/dms/colors.kdl".source = ./dms/colors.kdl;
  xdg.configFile."niri/dms/layout.kdl".source = ./dms/layout.kdl;
  xdg.configFile."niri/dms/alttab.kdl".source = ./dms/alttab.kdl;
  xdg.configFile."niri/dms/outputs.kdl".source = ./dms/outputs.kdl;
  xdg.configFile."niri/dms/cursor.kdl".source = ./dms/cursor.kdl;
  xdg.configFile."niri/dms/windowrules.kdl".source = ./dms/windowrules.kdl;
  xdg.configFile."niri/dms/wpblur.kdl".source = ./dms/wpblur.kdl;
  xdg.configFile."niri/dms/fw12_binds.kdl".source = ./fw12_binds.kdl;
  xdg.configFile."niri/dms/mycorrhiza_binds.kdl".source = ./mycorrhiza_binds.kdl;
}
