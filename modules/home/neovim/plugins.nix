{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "nix"
          "lua"
          "python"
          "bash"
          "json"
          "yaml"
          "markdown"
          "markdown_inline"
          "latex"
          "vim"
          "vimdoc"
          "query"
          "toml"
        ];
        highlight.enable = true;
        indent.enable = true;
      };
    };

    telescope = {
      enable = true;
      extensions.fzf-native.enable = true;
    };

    cmp = {
      enable = true;
      settings = {
        snippet.expand = ''
          function(args) require('luasnip').lsp_expand(args.body) end
        '';
        mapping = {
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = false })";
          "<Tab>" =
            "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { 'i', 's' })";
          "<S-Tab>" =
            "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { 'i', 's' })";
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
        ];
      };
    };
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    luasnip.enable = true;

    gitsigns.enable = true;

    which-key.enable = true;
    lualine.enable = true;
    indent-blankline.enable = true;
    alpha = {
      enable = true;
      theme = "dashboard";
    };

    toggleterm = {
      enable = true;
      settings.direction = "float";
    };

    nvim-autopairs.enable = true;
    nvim-surround.enable = true;
    trouble.enable = true;
    yazi.enable = true;
    lazygit.enable = true;

    lsp.servers.r_language_server = {
      enable = true;
      package = null;
    };
    lsp.servers.ruff.enable = true;
  };
}
