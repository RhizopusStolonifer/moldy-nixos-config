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
      settings.sources = [
        { name = "nvim_lsp"; }
        { name = "path"; }
        { name = "buffer"; }
        { name = "luasnip"; }
      ];
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
  };
}
