{ pkgs, inputs, username, ...}:
{
  home-manager-users.${username} = {
    imports = [ inputs.noctalia.homeModules.default ];

    programs.noctalia = {
      enable = true;
      settings = {

      };
    };
  };
}
