return {
  -- Copilot
  {
    'github/copilot.vim',
    event = 'BufEnter',
    config = function()
      vim.g.copilot_filetypes = {
        ['TelescopePrompt'] = false,
        ['copilot-chat'] = false,
        ['snack_terminal'] = false,
      }
      vim.g.copilot_assume_mapped = true
    end,
  },
  -- Autocomplete
  {
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      {
        'fang2hou/blink-copilot',
        opts = {
          max_completions = 1, -- Global default for max completions
          max_attempts = 2, -- Global default for max attempts
          kind = 'Copilot',
        },
      },
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = 'super-tab',
        ['<C-j>'] = { 'select_next', 'fallback' },
        ['<C-k>'] = { 'select_prev', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = { documentation = { auto_show = true } },
      signature = { enabled = false },
      snippets = { preset = 'luasnip' },
      sources = {
        default = { 'copilot', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          copilot = {
            name = 'copilot',
            module = 'blink-copilot',
            score_offset = 100,
            async = true,
            opts = { max_completions = 3 },
          },
        },
      },
      cmdline = { enabled = true },
      enabled = function()
        return not vim.tbl_contains({ 'copilot-chat' }, vim.bo.filetype) and vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
      end,
    },
    opts_extend = { 'sources.compat', 'sources.default' },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        '<leader>bf',
        function()
          require('conform').format { async = true }
        end,
        mode = { 'n', 'v' },
        desc = '[B]uffer [F]ormat',
      },
    },
    opts = {
      -- Define your formatters
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'ruff', 'isort', 'black' },
        javascript = { 'eslint_d', 'prettierd', 'prettier', stop_after_first = true },
      },
      -- Set default options
      default_format_opts = {
        lsp_format = 'fallback',
      },
      -- Set up format-on-save
      format_on_save = { timeout_ms = 500, lsp_format = 'fallback' },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      { 'm', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
      { 'T', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
  },
}
