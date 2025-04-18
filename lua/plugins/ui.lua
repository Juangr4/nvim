return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'
      configs.setup {
        ensure_installed = {
          'c',
          'lua',
          'vim',
          'vimdoc',
          'query',
          'python',
          'java',
          'javascript',
          'html',
          'css',
          'typescript',
          'jsonc',
          'yaml',
          'dockerfile',
          'regex',
          'markdown',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    dependencies = {
      'moll/vim-bbye',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local options = {
        mode = 'buffers',
        show_buffer_icons = true,
        diagnostic = 'nvim_lsp',
        separator_style = 'slant',
        indicator = {
          style = 'underline',
        },
        icon_pinned = '󰐃',
        minimum_padding = 1,
        maximum_padding = 5,
        maximum_length = 15,
        sort_by = 'insert_at_end',
      }
      require('bufferline').setup { options = options }
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      require('mini.tabline').setup()
      require('mini.pairs').setup()
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          -- ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
        untracked = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
        interval = 1000,
      },
      auto_attach = true,
      attach_to_untracked = true,
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        border = 'rounded',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
    },
  },
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = {
    { '<leader>dx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
    { '<leader>dX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Symbols (Trouble)' },
    { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)' },
    { '<leader>dL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
    { '<leader>dQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
  },
  {
    'stevearc/oil.nvim',
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    cmd = 'Oil',
    keys = {
      { '<leader>o', '<CMD>Oil<CR>', desc = 'Open Oil Explorer' },
    },
    config = function()
      require('oil').setup {
        default_file_explorer = false,
      }
    end,
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {},
    keys = {
      { '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', mode = { 'n' }, desc = 'Toggle [S]pectre' },
      { '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', mode = { 'n' }, desc = 'Search current [w]ord' },
      { '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', mode = { 'v' }, desc = 'Search current [w]ord' },
      { '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', mode = { 'n' }, desc = 'Search on current file' },
    },
  },
  {
    'OXY2DEV/markview.nvim',
    lazy = true,
    ft = { 'markdown', 'codecompanion', 'Avante' },
    opts = {
      preview = {
        filetypes = { 'markdown', 'codecompanion', 'Avante' },
        ignore_buftypes = {},
      },
    },
  },
  {
    'elkowar/yuck.vim',
    ft = { 'yuck' },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      spec = {
        mode = { 'n' },
        { '<leader>f', group = '[F]iles', icon = '' },
        { '<leader>s', group = '[S]earch', icon = '' },
        { '<leader>w', group = '[W]indow', icon = '' },
        { '<leader>t', group = '[T]ab Keymaps', icon = '󰖲' },
        { '<leader>g', group = '[G]it', icon = '' },
        { '<leader>d', group = '[D]iagnostics', icon = '' },
        { '<leader>b', group = '[B]uffers', icon = '' },
        { '<leader>l', group = 'Uti[l]s', icon = '' },
        { '<leader>c', group = '[C]ode', icon = '' },
        { '<leader>q', group = '[Q]uit', icon = '󰩈' },
        { '<leader>a', group = '[A]vante', icon = ' ' },
        -- Create some for better UI
        { '<leader>z', group = 'Open Lazy Menu', icon = '󰒲' },
        { '<leader>e', icon = '󰙅' },
        { '<leader><space>', icon = '󰱼' },
        { '<leader>/', icon = '󰱼' },
      },
      icons = {
        group = '',
      },
    },
  },
}
