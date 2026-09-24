{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        pyright.enable = true; # python
        bashls.enable = true; # bash
        lua_ls.enable = true; # lua
        marksman.enable = true; # markdown
        texlab.enable = true; # latex
        nixd.enable = true; # nix
        jsonls.enable = true; # vscode-langservers-extracted
        yamlls.enable = true; # yaml-language-server
      };
      keymaps = {
        lspBuf = {
          "gd" = "definition";
          "gr" = "references";
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
          python = [ "black" ];
          lua = [ "stylua" ];
          nix = [ "nixfmt" ];
          sh = [ "shfmt" ];
        };
        format_on_save = ''
          function(bufnr)
            return { timeout_ms = 500, lsp_fallback = true }
          end
        '';
      };
    };
  };
}
