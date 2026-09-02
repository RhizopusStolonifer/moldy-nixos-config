{ pkgs, username, ...}:
{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Rhizopus Stolonifer";
        email = "codeberg.pension282@passmail.net";
      };

      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
