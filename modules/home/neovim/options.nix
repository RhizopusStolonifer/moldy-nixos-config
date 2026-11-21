{
  programs.nixvim.opts = {
    number = true;
    relativenumber = true;
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    smartindent = true;
    ignorecase = true;
    smartcase = true;
    signcolumn = "yes";
    scrolloff = 8;
    updatetime = 250;
    termguicolors = true;
    clipboard = "unnamedplus";
    undofile = true;
    swapfile = false;
    splitright = true;
    splitbelow = true;
    cursorline = true;
    wrap = false;
    inccommand = "split";
    timeoutlen = 300;
    completeopt = "menu,menuone,noselect";
  };
}
