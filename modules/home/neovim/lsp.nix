{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
      servers = {
        pyright.enable = true;
        bashls.enable = true;
        lua_ls.enable = true;
        marksman.enable = true; # markdown
        texlab.enable = true;
        nixd.enable = true;
        jsonls.enable = true; # vscode-langservers-extracted
        yamlls.enable = true;
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
