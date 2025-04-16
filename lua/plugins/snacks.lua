local logo = [[
   _____ _                         __                                              __                 
  / ___/(_)  ____  __  _____  ____/ ___  _____   ____  ___  ____  _________ ______/ /___              
  \__ \/ /  / __ \/ / / / _ \/ __  / _ \/ ___/  / __ \/ _ \/ __ \/ ___/ __ `/ ___/ / __ \             
 ___/ / /  / /_/ / /_/ /  __/ /_/ /  __(__  )  / /_/ /  __/ / / (__  / /_/ / /  / / /_/ /             
/____/_/  / .___/\__,_/\___/\__,_/\___/____/  / .___/\___/_/ /_/____/\__,_/_/  /_/\____/              
         /_/              __                 /_/                                                __    
    ____  __  _____  ____/ ___  _____   ____  _________  ____ __________ _____ ___  ____ ______/ /___ 
   / __ \/ / / / _ \/ __  / _ \/ ___/  / __ \/ ___/ __ \/ __ `/ ___/ __ `/ __ `__ \/ __ `/ ___/ / __ \
  / /_/ / /_/ /  __/ /_/ /  __(__  )  / /_/ / /  / /_/ / /_/ / /  / /_/ / / / / / / /_/ / /  / / /_/ /
 / .___/\__,_/\___/\__,_/\___/____/  / .___/_/   \____/\__, /_/   \__,_/_/ /_/ /_/\__,_/_/  /_/\____/ 
/_/                                 /_/               /____/                                          
                                                                                By @Juangr4           
]]

logo = string.rep('\n', 4) .. logo .. '\n\n'

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 4, -- empty columns between vertical panes
      autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
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
          { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath 'config' })" },
          { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
          { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy },
          { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
        },
        -- Used by the `header` section
        header = logo,
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
    },
    picker = {
      enabled = true,
      sources = {
        files = { hidden = true, follow = true },
        explorer = {
          layout = { layout = { position = 'right' } },
        },
      },
      layout = { layout = { backdrop = true } },
      formatters = { file = { filename_first = true } },
      previewers = { git = { native = true, cmd = { 'delta ' } } },
      icons = { files = { enabled = true } },
    },
    notifier = {
      enabled = true,
      style = 'fancy',
      level = vim.log.levels.WARN,
      timeout = 3000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      -- editor margin to keep free. tabline and statusline are taken into account automatically
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true, -- add 1 cell of left/right padding to the notification window
      sort = { 'level', 'added' }, -- sort by level and time
      icons = { error = ' ', warn = ' ', info = ' ', debug = ' ', trace = ' ' },
      keep = function(notif)
        return vim.fn.getcmdpos() > 0
      end,
      top_down = true, -- place notifications from top to bottom
      date_format = '%R', -- time format for notifications
      -- format for footer when more lines are available
      -- `%d` is replaced with the number of lines.
      -- only works for styles with a border
      ---@type string|boolean
      more_format = ' ↓ %d lines ',
      refresh = 50, -- refresh at most every 50ms
    },
    indent = {
      indent = { enabled = false },
      ---@class snacks.indent.Scope.Config: snacks.scope.Config
      scope = {
        enabled = true,
        ---@type snacks.animate.Config|{enabled?: boolean}
        animate = { enabled = false },
        char = '│',
        underline = false, -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = 'SnacksIndentScope', ---@type string|string[] hl group for scopes
      },
      chunk = { enabled = false },
      blank = { char = ' ', hl = 'SnacksIndentBlank' },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      end,
      priority = 200,
    },
    zen = {
      enabled = true,
      win = { backdrop = { transparent = false } },
      toggles = { dim = false },
      show = { statusline = false, tabline = true },
      zoom = {
        toggles = { dim = false, git_signs = false, mini_diff_signs = false },
        show = { statusline = false, tabline = true },
        win = { backdrop = { transparent = false }, width = 120 },
      },
    },
    images = {
      enabled = true,
      doc = { enabled = true, inline = false, float = true },
    },
    scratch = {
      enabled = true,
      ft = function()
        if vim.bo.buftype == '' and vim.bo.filetype ~= '' then
          return vim.bo.filetype
        end
        return 'markdown'
      end,
    },
    styles = { notification = { wo = { wrap = true } } },
    quickfile = { exclude = { 'latex' } },
    explorer = { enabled = true },
    bigfile = { enabled = false },
    input = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = true },
    terminal = {
      bo = { filetype = 'snacks_terminal' },
      win = {
        position = 'float',
        width = math.floor(vim.o.columns * 0.7),
        height = math.floor(vim.o.lines * 0.7),
        border = 'rounded',
      },
    },
  },
  keys = {
    -- Snacks Picker (Search)
    {
      '<leader><space>',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Search in Files',
    },
    {
      '<leader>s,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>s:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>sn',
      function()
        Snacks.picker.notifications()
      end,
      desc = '[N]otification History',
    },
    {
      '<leader>si',
      function()
        Snacks.picker.icons()
      end,
      desc = 'Icons',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,
      desc = '[D]iagnostics',
    },
    {
      '<leader>sD',
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = 'Buffer [D]iagnostics',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Find [C]onfig File',
    },
    -- Utils
    {
      '<leader>lC',
      function()
        Snacks.picker.colorschemes()
      end,
      desc = 'Colorschemes',
    },
    {
      '<leader>ln',
      function()
        Snacks.notifier.show_history()
      end,
      desc = '[N]otification History',
    },
    {
      '<leader>lN',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All [N]otifications',
    },
    {
      '<leader>l.',
      function()
        Snacks.scratch()
      end,
      desc = 'Toggle Scratch Buffer',
    },
    {
      '<leader>lS',
      function()
        Snacks.scratch.select()
      end,
      desc = 'Select [S]cratch Buffer',
    },
    {
      '<leader>lz',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle [Z]en Mode',
    },
    -- Git
    {
      '<leader>gg',
      function()
        Snacks.lazygit()
      end,
      desc = 'Lazy[g]it',
    },
    {
      '<leader>gf',
      function()
        Snacks.lazygit.log_file()
      end,
      desc = 'Lazygit Current [F]ile History',
    },
    {
      '<leader>gl',
      function()
        Snacks.lazygit.log()
      end,
      desc = 'Lazygit [L]og (cwd)',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git [B]rowse',
    },
    {
      '<leader>gb',
      function()
        Snacks.git.blame_line()
      end,
      desc = 'Git [B]lame Line',
    },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log()
      end,
      desc = 'Git [L]og',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git [S]tatus',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git [S]tash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git [D]iff (Hunks)',
    },
    {
      '<leader>gF',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log [F]ile',
    },
    -- Other
    {
      '<leader>e',
      function()
        Snacks.explorer { auto_close = true }
      end,
      desc = 'File Explorer',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = '[D]elete Buffer',
    },
    {
      '<leader>fr',
      function()
        Snacks.rename.rename_file()
      end,
      desc = '[R]ename File',
    },
    {
      '<c-ç>',
      function()
        Snacks.terminal()
      end,
      desc = 'Toggle Terminal',
    },
    -- { '<c-_>', function() Snacks.terminal() end, desc = 'which_key_ignore', },
    {
      ']]',
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = 'Next Reference',
      mode = { 'n', 't' },
    },
    {
      '[[',
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = 'Prev Reference',
      mode = { 'n', 't' },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = '[S]pelling' }):map '<leader>ls'
        Snacks.toggle.option('wrap', { name = '[W]rap' }):map '<leader>lw'
        Snacks.toggle.option('relativenumber', { name = 'Re[l]ative Number' }):map '<leader>lL'
        Snacks.toggle.diagnostics():map '<leader>ld'
        Snacks.toggle.line_number():map '<leader>ll'
        Snacks.toggle.treesitter():map '<leader>lT'
        Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>lb'
        Snacks.toggle.indent():map '<leader>lg'
      end,
    })
  end,
}
