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
      -- Check if the platform is Windows
      -- If so, set the viewer to System default PDF viewer
      if vim.fn.has 'win32' == 1 then
        vim.g.vimtex_view_method = 'general'
      else
        vim.g.vimtex_view_method = 'zathura'
      end
      vim.g.vimtex_view_forward_search_on_start = false
    end,
  },
}
