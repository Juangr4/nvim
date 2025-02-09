return {
  {
    'nvim-treesitter/nvim-treesitter',
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
          'latex',
          'markdown',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
