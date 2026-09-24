{
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
      }
      {
        mode = "n";
        key = "<leader>cf";
        action = "<cmd>lua require('conform').format()<CR>";
      }
      {
        mode = "n";
        key = "<leader>gg";
        action.__raw = ''
          function()
            require("toggleterm.terminal").Terminal:new({
              cmd = "lazygit",
              direction = "float",
              hidden = true,
            }):toggle()
          end
        '';
      }
    ];
  };
}
