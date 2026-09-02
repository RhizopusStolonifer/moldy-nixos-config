{ pkgs, ... }:
{
  programs.bat = {
    enable = true;
    config = {
      theme = "dracula";
    };
    extraPackages = with pkgs.bat-extras; [
      batman
      batpipe
    ];
  };
}
