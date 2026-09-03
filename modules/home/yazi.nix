{ ... }:
{
  programs.yazi = {
    enable = true;

    plugins = with pkgs.yaziPlugins; {
      smart-enter.package = smart-enter;
      chmod.package = chmod;
      sudo.package = sudo;
      lsar.package = lsar;
      mount.package = mount;
      restore.package = restore;
      yafg.package = yafg;
      drag.package = drag;
      smart-filter.package = smart-filter;
      wl-clipboard.package = wl-clipboard;
    };
  };
}
