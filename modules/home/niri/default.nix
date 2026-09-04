{
  config,
  lib,
  pkgs,
  host,
  ...
}:

{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  xdg.configFile."niri/dms/binds.kdl".source = ./binds.kdl;
  xdg.configFile."niri/dms/binds-host.kdl".source =
    if host == "mycorrhiza" then
      ./binds-mycorrhiza.kdl
    else if host == "fw12" then
      ./binds-fw12.kdl
    else
      ./binds.kdl;
}
