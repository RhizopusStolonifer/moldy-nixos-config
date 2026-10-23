{ host, ... }:
{
  xdg.configFile."hypr/hyprland.lua".source = ./hyprland.lua;
  xdg.configFile."hypr/binds.lua".source = ./binds.lua;
  #xdg.configFile."hypr/binds-host.lua".source =
  #  if host == "mycorrhiza" then
  #    ./binds-mycorrhiza.lua
  #  else if host == "fw12" then
  #    ./binds-fw12.lua
  #  else
}
