{ pkgs, inputs, ...}:
{
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      settings = {
        theme = {
          mode = "dark";
          source = "builtin";
           builtin = "Dracula";
        };
      };
    };
}
