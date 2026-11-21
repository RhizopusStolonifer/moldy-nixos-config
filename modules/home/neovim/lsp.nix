{ host, username, ... }:
let
  flake = ''(builtins.getFlake "/home/${username}/moldy-nixos-config")'';
in
{
  programs.nixvim.plugins.lsp.servers.nixd = {
    enable = true;
    settings = {
      nixpkgs.expr = "import ${flake}.inputs.nixpkgs { }";
      options = {
        nixos.expr = "${flake}.nixosConfigurations.${host}.options";
        home-manager.expr = "${flake}.nixosConfigurations.${host}.options.home-manager.users.type.getSubOptions [ ]";
      };
    };
  };

  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
        bashls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true; # markdown
        texlab.enable = true;
        jsonls.enable = true; # vscode-langservers-extracted
        yamlls.enable = true;
      };
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "grr" = "references";
          "K" = "hover";
          "<leader>lr" = "rename";
          "<leader>la" = "code_action";
        };
      };
    };

    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          python = [ "ruff_format" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          sh = [ "shfmt" ];
        };
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat then return end
            return { timeout_ms = 500, lsp_format = 'fallback' }
          end
        '';
      };
    };
  };
}
