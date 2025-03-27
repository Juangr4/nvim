-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_newtrwSettings = 1
-- vim.g.loaded_newtrwFileHandlers = 1
-- vim.g.loaded_newtrw_gitignore = 1

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    if vim.fn.argv(0) == '.' then
      Snacks.picker.files()
    end
  end,
})

-- vim.api.nvim_create_autocmd('BufEnter', {
--   callback = function()
--     if vim.bo.filetype == 'directory' then
--       Snacks.picker.files()
--     end
--   end,
-- })

vim.api.nvim_create_user_command('UpdateConfigFromRepo', function()
  vim.fn.system { 'git', '-C', vim.fn.stdpath 'config', 'pull' }
end, {})
