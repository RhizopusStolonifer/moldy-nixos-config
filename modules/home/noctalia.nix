{ pkgs, inputs, username, ...}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;
    settings = {

    };
  };
}
