return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
      -- These settings are used by some built-in sections
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        -- Used by the `keys` section to show keymaps.
        -- Set your custom keymaps here.
        -- When using a function, the `items` argument are the default keymaps.
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
          { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          -- { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = ' ', key = 'c', desc = 'Config', action = function () vim.cmd 'cd ~/.config/nvim' Snacks.dashboard.pick('files') end },
          { icon = ' ', key = 'N', desc = 'Notes', action = function () vim.cmd 'cd ~/notes' Snacks.dashboard.pick('files') end },
          -- { icon = ' ', key = 'p', desc = 'Projects', action = ":lua Snacks.dashboard.pick('projects')" },
          -- { icon = ' ', key = 'b', desc = 'Buffers', action = ":lua Snacks.dashboard.pick('buffers')" },
          -- { icon = ' ', key = 'm', desc = 'Marks', action = ":lua Snacks.dashboard.pick('marks')" },
          -- { icon = ' ', key = 't', desc = 'Tags', action = ":lua Snacks.dashboard.pick('tags')" },
          -- { icon = ' ', key = 'h', desc = 'History', action = ":lua Snacks.dashboard.pick('history')" },
          -- { icon = ' ', key = 'o', desc = 'Options', action = ":lua Snacks.dashboard.pick('options')" },
          -- { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        -- Used by the `header` section
        header = [[
╔══════════════════════════════════════════════════════════════════════════════════╗
║                                                                                  ║
║  ██╗    ██╗      ██████╗ ██╗   ██╗███████╗     ██████╗ ██████╗ ██████╗ ███████╗  ║
║  ██║    ██║     ██╔═══██╗██║   ██║██╔════╝    ██╔════╝██╔═══██╗██╔══██╗██╔════╝  ║
║  ██║    ██║     ██║   ██║██║   ██║█████╗      ██║     ██║   ██║██║  ██║█████╗    ║
║  ██║    ██║     ██║   ██║╚██╗ ██╔╝██╔══╝      ██║     ██║   ██║██║  ██║██╔══╝    ║
║  ██║    ███████╗╚██████╔╝ ╚████╔╝ ███████╗    ╚██████╗╚██████╔╝██████╔╝███████╗  ║
║  ╚═╝    ╚══════╝ ╚═════╝   ╚═══╝  ╚══════╝     ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝  ║
║                                                                                  ║
╚══════════════════════════════════════════════════════════════════════════════════╝]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == 'file' or item.icon == 'directory' then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = 'icon' }
        end,
        footer = { '%s', align = 'center' },
        header = { '%s', align = 'center' },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ':~')
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ':h')
            local file = vim.fn.fnamemodify(fname, ':t')
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. '/…' .. file
            end
          end
          local dir, file = fname:match '^(.*)/(.+)$'
          return dir and { { dir .. '/', hl = 'dir' }, { file, hl = 'file' } } or { { fname, hl = 'file' } }
        end,
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
        -- {
        --   section = 'terminal',
        --   cmd = 'pokemon-colorscripts -r --no-title; sleep .1',
        --   random = 10,
        --   pane = 2,
        --   padding = 1,
        --   indent = 4,
        --   enabled = function()
        --     return vim.loop.os_uname().sysname == 'Linux'
        --   end,
        --   height = 30,
        -- },
      },
    },
    notifier = {
      timeout = 3000, -- default timeout in ms
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      sort = { 'level', 'added' }, -- sort by level and time
      -- minimum log level to display. TRACE is the lowest
      -- all notifications are stored in history
      level = vim.log.levels.TRACE,
      icons = {
        error = ' ',
        warn = ' ',
        info = ' ',
        debug = ' ',
        trace = ' ',
      },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      ---@type snacks.notifier.style
      style = 'compact',
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },
    lazygit = {
      -- automatically configure lazygit to use the current colorscheme
      -- and integrate edit with the current neovim instance
      configure = true,
      -- extra configuration for lazygit that will be merged with the default
      -- snacks does NOT have a full yaml parser, so if you need `"test"` to appear with the quotes
      -- you need to double quote it: `"\"test\""`
      config = {
        os = { editPreset = 'nvim-remote' },
        gui = {
          -- set to an empty string "" to disable icons
          nerdFontsVersion = '3',
        },
      },
      theme_path = vim.fs.normalize(vim.fn.stdpath 'cache' .. '/lazygit-theme.yml'),
      -- Theme for lazygit
      theme = {
        [241] = { fg = 'Special' },
        activeBorderColor = { fg = 'MatchParen', bold = true },
        cherryPickedCommitBgColor = { fg = 'Identifier' },
        cherryPickedCommitFgColor = { fg = 'Function' },
        defaultFgColor = { fg = 'Normal' },
        inactiveBorderColor = { fg = 'FloatBorder' },
        optionsTextColor = { fg = 'Function' },
        searchingActiveBorderColor = { fg = 'MatchParen', bold = true },
        selectedLineBgColor = { bg = 'Visual' }, -- set to `default` to have no background colour
        unstagedChangesColor = { fg = 'DiagnosticError' },
      },
      win = {
        style = 'lazygit',
      },
    },
    indent = {
      indent = {
        enabled = false, -- enable indent guides
        char = '│',
        blank = ' ',
        -- blank = "∙",
        only_scope = true, -- only show indent guides of the scope
        only_current = true, -- only show indent guides in the current window
        hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
      },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true, -- enable highlighting the current scope
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@type snacks.animate.Config|{enabled?: boolean}
        animate = {
          -- enabled = vim.fn.has 'nvim-0.10' == 1,
          enabled = false,
          easing = 'linear',
          duration = {
            step = 20, -- ms per step
            total = 500, -- maximum duration
          },
        },
        char = '│',
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = false,
        -- only show chunk scopes in the current window
        only_current = false,
        hl = 'SnacksIndentChunk', ---@type string|string[] hl group for chunk scopes
        char = {
          corner_top = '┌',
          corner_bottom = '└',
          -- corner_top = "╭",
          -- corner_bottom = "╰",
          horizontal = '─',
          vertical = '│',
          arrow = '>',
        },
      },
      blank = {
        char = ' ',
        -- char = "·",
        hl = 'SnacksIndentBlank', ---@type string|string[] hl group for blank spaces
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
      priority = 200,
    },
    quickfile = {
      exclude = { 'latex' },
    },
    zen = {
      toggles = {
        dim = true,
        git_signs = false,
        mini_diff_signs = false,
        -- diagnostics = false,
        -- inlay_hints = false,
      },
      show = {
        statusline = false, -- can only be shown when using the global statusline
        tabline = false,
      },
      ---@type snacks.win.Config
      win = { style = 'zen' },

      --- Options for the `Snacks.zen.zoom()`
      ---@type snacks.zen.Config
      zoom = {
        toggles = {},
        show = { statusline = true, tabline = true },
        win = {
          backdrop = false,
          width = 0, -- full width
        },
      },
    },
    bigfile = { enabled = false },
    input = { enabled = true },
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 15, total = 250 },
        easing = 'linear',
      },
      -- what buffers to animate
      filter = function(buf)
        return vim.g.snacks_scroll ~= false and vim.b[buf].snacks_scroll ~= false and vim.bo[buf].buftype ~= 'terminal'
      end,
    },
    statuscolumn = {
      enabled = false,
      left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
      right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
      folds = {
        open = false, -- show open fold icons
        git_hl = false, -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = { 'GitSign', 'MiniDiffSign' },
      },
      refresh = 50, -- refresh at most every 50ms
    },
    git = {
      width = 0.6,
      height = 0.6,
      border = 'rounded',
      title = ' Git Blame ',
      title_pos = 'center',
      ft = 'git',
    },
    words = {
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { 'n', 'i', 'c' }, -- modes to show references
    },
    picker = {},
    images = {
      formats = { "png", "jpg", "jpeg", "gif", "bmp", "webp", "tiff", "heic", "avif", "mp4", "mov", "avi", "mkv", "webm" },
      force = false, -- try displaying the image, even if the terminal does not support it
      doc = {
        enabled = true,
        inline = true,
        float = true,
        max_width = 80,
        max_height = 40,
      },
      img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
      wo = {
        wrap = false,
        number = false,
        relativenumber = false,
        cursorcolumn = false,
        signcolumn = "no",
        foldcolumn = "0",
        list = false,
        spell = false,
        statuscolumn = "",
      },
      cache = vim.fn.stdpath("cache") .. "/snacks/image",
      debug = {
        request = false,
        convert = false,
        placement = false,
      },
      env = {},
    },
  },
  keys = {
    -- Snacks Picker
    { '<leader><space>', function () Snacks.picker.smart() end, desc = 'Smart Find files'},
    -- { '<leader><space>', function() Snacks.picker.buffers() end, desc = 'Buffers', },
    { '<leader>sb', function() Snacks.picker.lines() end, desc = 'Buffer Lines', },
    { '<leader>sf', function() Snacks.picker.files() end, desc = 'Find Files', },
    { '<leader>sg', function() Snacks.picker.grep() end, desc = 'Grep', },
    { '<leader>s:', function() Snacks.picker.command_history() end, desc = 'Command History', },
    { '<leader>sn', function() Snacks.picker.notifications() end, desc = 'Notification History', },
    { '<leader>si', function() Snacks.picker.icons() end, desc = 'Icons', },
    { '<leader>sd', function() Snacks.picker.diagnostics_buffer() end, desc = 'Buffer Diagnostics', },
    { '<leader>sc', function() Snacks.picker.files { cwd = vim.fn.stdpath('config') } end, desc = 'Find Config File', },
    -- { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = 'Diagnostics', },
    -- { '<leader>sc', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = 'Find Config File', },
    -- Utils
    { '<leader>lC', function() Snacks.picker.colorschemes() end, desc = 'Colorschemes', },
    { '<leader>lh', function() Snacks.notifier.show_history() end, desc = 'Notification History', },
    { '<leader>ln', function() Snacks.notifier.hide() end, desc = 'Dismiss All Notifications', },
    -- Git
    { '<leader>gB', function() Snacks.gitbrowse() end, desc = 'Git Browse', },
    { '<leader>gb', function() Snacks.git.blame_line() end, desc = 'Git Blame Line', },
    { '<leader>gf', function() Snacks.lazygit.log_file() end, desc = 'Lazygit Current File History', },
    { '<leader>gg', function() Snacks.lazygit() end, desc = 'Lazygit', },
    { '<leader>gl', function() Snacks.lazygit.log() end, desc = 'Lazygit Log (cwd)', },
    { '<leader>gl', function() Snacks.picker.git_log() end, desc = 'Git Log', },
    { '<leader>gL', function() Snacks.picker.git_log_line() end, desc = 'Git Log Line', },
    { '<leader>gs', function() Snacks.picker.git_status() end, desc = 'Git Status', },
    { '<leader>gd', function() Snacks.picker.git_diff() end, desc = 'Git Diff (Hunks)', },
    { '<leader>gf', function() Snacks.picker.git_log_file() end, desc = 'Git Log File', },
    -- LSP
    { 'gd', function() Snacks.picker.lsp_definitions() end, desc = 'Goto Definition', },
    { 'gD', function() Snacks.picker.lsp_declarations() end, desc = 'Goto Declaration', },
    { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = 'References', },
    { 'gI', function() Snacks.picker.lsp_implementations() end, desc = 'Goto Implementation', },
    { 'gy', function() Snacks.picker.lsp_type_definitions() end, desc = 'Goto T[y]pe Definition', },
    -- Other
    { '<leader>lz', function() Snacks.zen() end, desc = 'Toggle Zen Mode', },
    -- { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom', },
    { '<leader>l.', function() Snacks.scratch() end, desc = 'Toggle Scratch Buffer', },
    { '<leader>lS', function() Snacks.scratch.select() end, desc = 'Select Scratch Buffer', },
    { '<leader>bd', function() Snacks.bufdelete() end, desc = 'Delete Buffer', },
    { '<leader>fr', function() Snacks.rename.rename_file() end, desc = 'Rename File', },
    { '<c-/>', function() Snacks.terminal() end, desc = 'Toggle Terminal', },
    { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore', },
    { ']]', function() Snacks.words.jump(vim.v.count1) end, desc = 'Next Reference', mode = { 'n', 't' }, },
    { '[[', function() Snacks.words.jump(-vim.v.count1) end, desc = 'Prev Reference', mode = { 'n', 't' }, },
    {
      '<leader>lN',
      desc = 'Neovim News',
      function()
        Snacks.win {
          file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = 'yes',
            statuscolumn = ' ',
            conceallevel = 3,
          },
        }
      end,
    },
  },
}
