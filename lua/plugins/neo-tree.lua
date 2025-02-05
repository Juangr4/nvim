return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
      require('neo-tree').setup {
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = true,
            hide_gitignored = false,
          },
        },
        window = {
          width = 30,
        },
        default_component_configs = {
          git_status = {
            symbols = {
              -- Change type
              added = '✚', -- NOTE: you can set any of these to an empty string to not show them
              deleted = '✖',
              modified = '',
              renamed = '󰁕',
              -- Status type
              untracked = '', --'',
              ignored = '', --'',
              unstaged = '', --'󰄱',
              staged = '', --'',
              conflict = '',
            },
            align = 'right',
          },
        },
      }
      vim.keymap.set('n', '<leader>e', ':Neotree toggle position=left<CR>', { noremap = true, silent = true, desc = 'Open [E]xplorer Tree' })
    end,
  },
}
