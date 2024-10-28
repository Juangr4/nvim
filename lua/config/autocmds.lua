vim.cmd [[autocmd BufEnter * if &filetype == 'directory' | Telescope find_files<CR> endif]]
