return {
  'stevearc/oil.nvim',
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  -- opts = {},
  keys = {
    { '<leader>o', '<CMD>Oil<CR>', desc = 'Open Oil Explorer' },
  },
  config = function()
    require('oil').setup {
      default_file_explorer = false,
    }
  end,
}
