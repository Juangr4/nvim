-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

local opt = vim.o

-- Line numbers
opt.number = true -- Show line numbers (default: false)
opt.relativenumber = true -- Show relative line numbers (default: false)

-- UI settings
opt.signcolumn = 'yes' -- Keep signcolumn on by default (default: 'auto')
opt.splitkeep = 'screen' -- Keep the cursor in the same position when splitting (default: 'screen')
opt.splitbelow = true -- Force all horizontal splits to go below current window (default: false)
opt.splitright = true -- Force all vertical splits to go to the right of current window (default: false)
opt.mouse = 'a' -- Enable mouse mode (default: '')
opt.termguicolors = true -- Set termguicolors to enable highlight groups (default: false)
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore (default: true). We have a statusline.
opt.conceallevel = 0 -- So that `` is visible in markdown files (default: 1)
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.pumblend = 10 -- Popup menu transparency (default: 0)
opt.pumheight = 10 -- Pop up menu height (default: 0). Maximum number of items to show in the pop up menu

-- Indentation
opt.expandtab = true -- Convert tabs to spaces (default: false)
opt.tabstop = 2 -- Insert n spaces for a tab (default: 8)
opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations (default: 8)
opt.shiftwidth = 2 -- The number of spaces inserted for each indentation (default: 8)
opt.smartindent = true -- Make indenting smarter again (default: false)

-- Search settings
opt.hlsearch = false -- Highlight all matches on previous search pattern (default: true)
opt.incsearch = true -- Show where the pattern is matched as you type (default: false)
opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search (default: false)
opt.smartcase = true -- Smart case (default: false)
opt.grepformat = '%f:%l:%c:%m' -- Format for grep (default: '%f:%l:%m')
opt.grepprg = 'rg --vimgrep' -- Use ripgrep for grep (default: 'grep')
opt.inccommand = 'nosplit' -- Enable live substitution (default: 'nosplit')

-- Scrolling settings
opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor (default: 0)
opt.sidescrolloff = 8 -- Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)

-- Misc settings
opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim. (default: '')
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key. Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)

-- Don't know how to classify this
opt.completeopt = 'menu,menuone,noselect,fuzzy' -- Set completeopt to have a better completion experience (default: 'menu,preview')
opt.confirm = true -- Confirm before closing unsaved buffers (default: false)
opt.cursorline = true -- Highlight the current line (default: false)
opt.formatoptions = 'jcroqlnt' -- 'tcqj'
-- vim.opt.formatoptions:remove { 'c', 'r', 'o' } -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
opt.laststatus = 3 -- Always display the status line (default: 2). Global statusline
opt.linebreak = true -- Companion to wrap, don't split words (default: false)
opt.list = false -- Show some invisible characters (tabs, trailing whitespace, etc.) (default: false)
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '»', precedes = '«', nbsp = '␣' }
opt.ruler = false -- Disable the default ruler
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' } -- Session options (default: 'buffers,curdir,tabpages,winsize')
opt.shiftround = true -- Round indent
vim.opt.shortmess:append { W = true, I = true, c = true, C = true } -- Don't give |ins-completion-menu| messages (default: does not include 'c')
opt.spelllang = 'en_us' -- Spelling language (default: 'en_us')
vim.opt.spelloptions:append 'noplainbuffer'
opt.undofile = true -- Save undo history (default: false)
opt.undolevels = 10000 -- The maximum number of changes that can be undone (default: 1000)
opt.updatetime = 250 -- Decrease update time (default: 4000). Time in milliseconds to wait before triggering the 'updatetime' event
opt.virtualedit = 'block' -- Use block cursor in insert mode (default: 'block'). Allow cursor to move where there is no text in visual block mode.
opt.wildmode = 'longest:full,full' -- Command-line completion mode (default: 'list:full')
opt.winminwidth = 5 -- Minimum window width (default: 1)
opt.wrap = false -- Disable line wrap

opt.whichwrap = 'bs<>[]hl' -- Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
vim.o.numberwidth = 4 -- Set number column width to 2 {default 4} (default: 4)
vim.o.swapfile = false -- Creates a swapfile (default: true)
vim.o.showtabline = 2 -- Always show tabs (default: 1)
vim.o.backspace = 'indent,eol,start' -- Allow backspace on (default: 'indent,eol,start')
vim.o.writebackup = false -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited (default: true)
vim.opt.iskeyword:append '-' -- Hyphenated words recognized by searches (default: does not include '-')

vim.g.markdown_recommended_style = 0 -- Disable recommended style for markdown files (default: 1)

-- Folding
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.foldlevel = 99
opt.smoothscroll = true
opt.foldmethod = 'expr'
opt.foldtext = ''

-- Diagnostics
vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = 'if_many',
    prefix = '●',
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰌵 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
}

-- Disable providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0

if vim.g.neovide then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h14'
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_antialiasing = false
  vim.g.neovide_input_ime = true
end
