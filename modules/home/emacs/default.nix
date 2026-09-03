{ config, lib, pkgs, inputs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk; # native wayland GUI
  };

  home.activation.installDoomEmacs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  if [ ! -d "${config.home.homeDirectory}/.config/emacs" ]; then
    $DRY_RUN_CMD cp -r ${inputs.doom-emacs} "${config.home.homeDirectory}/.config/emacs"
    $DRY_RUN_CMD chmod -R u+w "${config.home.homeDirectory}/.config/emacs"
  fi

  if [ -x "${config.home.homeDirectory}/.config/emacs/bin/doom" ]; then
    $DRY_RUN_CMD "${config.home.homeDirectory}/.config/emacs/bin/doom" sync || true
  fi
'';

  xdg.configFile."doom/init.el".source = ./doom.d/init.el;
  xdg.configFile."doom/config.el".source = ./doom.d/config.el;
  xdg.configFile."doom/packages.el".source = ./doom.d/packages.el;
}
