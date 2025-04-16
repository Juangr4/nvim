-- Disable the spacebar key's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- For conciseness
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Common actions
-- map('n', '<leader>fw', '<cmd>w<cr>', 'Save file')
map('n', '<C-s>', '<cmd>w<cr>', 'Save file')
map('n', '<leader>fs', '<cmd>noautocmd w<cr>', '[S]ave file without formatting')
map('n', '<leader>qq', '<cmd>q<cr>', '[Q]uit')
map('n', '<C-q>', '<cmd>q<cr>', 'Quit')
map('n', '<leader>qa', '<cmd>qa!<cr>', 'Quit [a]ll')
-- map('n', '<leader>dw', '<cmd>close<cr>', 'Close windows')

-- Easier access to beginning and end of lines
map('n', '<A-h>', '^', 'Go to beginning of line')
map('n', '<A-l>', '$', 'Go to end of line')

-- Vertical scroll and center
map('n', '<C-d>', '<C-d>zz', 'Move down half page')
map('n', '<C-u>', '<C-u>zz', 'kove up half page')

-- Buffers
map('n', '<Tab>', ':bnext<CR>', 'Go to next buffer')
map('n', '<S-l>', ':bnext<CR>', 'Go to next buffer')
map('n', '<S-Tab>', ':bprevious<CR>', 'Go to previous buffer')
map('n', '<S-h>', ':bprevious<CR>', 'Go to previous buffer')
-- map('n', '<leader>bq', ':Bdelete!<CR>', 'Close buffer')
-- map('n', '<leader>bx', ':Bdelete!<CR>', 'Close buffer')
map('n', '<leader>bn', '<cmd>enew<CR>', 'Create a new buffer')
-- map('n', '<leader>bd', ':bd<CR>', 'Close the actual buffer')
map('n', '<leader>bq', ':%bd<CR>', 'Close all buffers')
map('n', '<leader>ba', ':%bd|e#<CR>', 'Close all buffers except the current one')

-- Window management
map('n', '<leader>wv', '<C-w>v', 'Split window vertically')
map('n', '<leader>wh', '<C-w>s', 'Split window horizontally')
map('n', '<leader>we', '<C-w>=', 'Make split Windows equal in width & height')
map('n', '<leader>wq', ':close<CR>', 'Close split window')

-- Resize with arrows
map('n', '<Up>', ':resize +2<CR>', 'Resize Windows')
map('n', '<Down>', ':resize -2<CR>', 'Resize Windows')
map('n', '<Left>', ':vertical resize +2<CR>', 'Resize Windows')
map('n', '<Right>', ':vertical resize -2<CR>', 'Resize Windows')

-- Navigate between windows
map('n', '<C-k>', ':wincmd k<CR>', 'Navigate window up')
map('n', '<C-j>', ':wincmd j<CR>', 'Navigate window down')
map('n', '<C-h>', ':wincmd h<CR>', 'Navigate window to the left')
map('n', '<C-l>', ':wincmd l<CR>', 'Navigate window to the right')

-- Tabs
map('n', '<leader>to', ':tabnew<CR>', 'Open a new tab')
map('n', '<leader>tx', ':tabclose<CR>', 'Close current tab')
map('n', '<leader>tn', ':tabn<CR>', 'Go to next tab')
map('n', '<leader>tp', ':tabp<CR>', 'Go to previous tab')

-- Some utilities

-- Toggle line wrapping
-- Now inside snacks.lua
-- map('n', '<leader>lw', '<cmd>set wrap!<CR>', 'Toggle line wrap')

-- Move lines
map('n', '<A-j>', ':m .+1<CR>==', 'Move line down')
map('n', '<A-k>', ':m .-2<CR>==', 'Move line up')
map('i', '<A-j>', '<esc><cmd>m .+1<CR>==gi', 'Move line down')
map('i', '<A-k>', '<esc><cmd>m .-2<CR>==gi', 'Move line up')
map('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", 'Move line down')
map('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", 'Move line down')

-- Clear search with <esc>
-- map({ 'i', 'n' }, '<esc>', ':noh<CR><esc>', 'Clear search highlight')

-- select all the file
map('n', '<C-a>', 'ggVG', 'Select all the file content')

-- delete single character without copying into register
map('n', 'x', '"_x', 'Delete without copying to clipboard')

-- Keep last yanked when pasting
map('v', 'p', '"_dP', 'Paste without losing clipboard')

-- Stay in indent mode
map('v', '<', '<gv', 'Indent')
map('v', '>', '>gv', 'Indent')

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.get_next or vim.diagnostic.get_prev
  severity = severity or vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, 'Open float diagnostic')
map('n', ']d', diagnostic_goto(true), 'Go to next diagnostic message')
map('n', '[d', diagnostic_goto(false), 'Go to previous diagnostic message')
map('n', ']e', diagnostic_goto(true, 'ERROR'), 'Go to next error message')
map('n', '[e', diagnostic_goto(false, 'ERROR'), 'Go to previous error message')
map('n', ']w', diagnostic_goto(true, 'WARN'), 'Go to next warning message')
map('n', '[w', diagnostic_goto(false, 'WARN'), 'Go to previous warning message')
-- map('n', '<leader>dl', vim.diagnostic.setloclist, 'Open diagnostics list')

-- Lazy
map('n', '<leader>zz', '<cmd>Lazy<CR>', 'Open Lazy Menu')
