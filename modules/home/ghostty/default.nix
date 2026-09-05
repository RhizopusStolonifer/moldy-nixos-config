{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;

    settings = {
      theme = "Dracula";
      background-opacity = "0.8";
    };
  };
  xdg.configFile."ghostty/themes/dracula".source = ./dracula;
}
