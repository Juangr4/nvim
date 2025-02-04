-- vim.cmd [[autocmd BufEnter * if &filetype == 'directory' | Telescope find_files<CR> endif]]
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argv(0) == '' then
      Snacks.picker.files()
    end
  end,
})
