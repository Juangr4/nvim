return {
  {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').load 'mocha'
      vim.cmd.colorscheme = 'catppuccin'
    end,
  },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    opts = {},
  },
  'rebelot/kanagawa.nvim',
  'ellisonleao/gruvbox.nvim',
  'nyoom-engineering/oxocarbon.nvim',
  'navarasu/onedark.nvim',
  'sainnhe/everforest',
  'Mofiqul/vscode.nvim',
}
