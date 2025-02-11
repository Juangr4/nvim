return {
  {
    'OXY2DEV/markview.nvim',
    lazy = true,
    ft = 'markdown',
  },
  {
    'lervag/vimtex',
    lazy = true,
    ft = 'tex',
    -- tag = "v2.15",
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_view_forward_search_on_start = false
    end,
  },
}
