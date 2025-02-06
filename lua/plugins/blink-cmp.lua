return {
  'saghen/blink.cmp',
  -- use a release tag to download pre-built binaries
  version = '*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  -- optional: provides snippets for the snippet source
  dependencies = {
    -- {
    --   'L3MON4D3/LuaSnip',
    --   version = 'v2.*',
    --   build = (function()
    --     -- Build Step is needed for regex support in snippets.
    --     -- This step is not supported in many windows environments.
    --     -- Remove the below condition to re-enable on windows.
    --     if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
    --       return
    --     end
    --     return 'make install_jsregexp'
    --   end)(),
    --   dependencies = {
    --     -- `friendly-snippets` contains a variety of premade snippets.
    --     --    See the README about individual language/framework/plugin snippets:
    --     --    https://github.com/rafamadriz/friendly-snippets
    --     {
    --       'rafamadriz/friendly-snippets',
    --       config = function()
    --         require('luasnip.loaders.from_vscode').lazy_load()
    --       end,
    --     },
    --   },
    -- },
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- See the full "keymap" documentation for information on defining your own keymap.
    keymap = {
      preset = 'default',
      ['<C-j>'] = { 'select_next', 'fallback' },
      ['<C-k>'] = { 'select_prev', 'fallback' },
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    -- snippets = { preset = 'luasnip' },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
