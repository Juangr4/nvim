return {
  {
    'catppuccin/nvim',
    enabled = true,
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').load 'mocha'
      vim.cmd.colorscheme = 'catppuccin'
    end,
  },
}
