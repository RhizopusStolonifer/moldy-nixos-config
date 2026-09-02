{ pkgs, inputs, ...}:
{
  home-manager.users.myco = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
           builtin = "Dracula";
        };
      };
    };
  };
}
