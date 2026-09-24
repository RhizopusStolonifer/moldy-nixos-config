{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./plugins.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = false;
    viAlias = false;
    vimAlias = false;
    nixpkgs.pkgs = pkgs;
  };

  stylix.targets.nixvim.plugin = "base16-nvim";
}
