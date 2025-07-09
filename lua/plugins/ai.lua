return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    opts = {},
    keys = {
      { '<leader>gcm', '<cmd>CopilotChatModels<CR>', desc = '[C]opilotChat [M]odels' },
      { '<leader>gca', '<cmd>CopilotChatAgents<CR>', desc = '[C]opilotChat [A]gents' },
      { '<leader>gcc', '<cmd>CopilotChatOpen<CR>', desc = '[C]opilotChat [C]hat' },
      { '<leader>gcC', '<cmd>CopilotChatCommit<CR>', desc = '[C]opilotChat [C]ommit' },
      { '<leader>gcp', '<cmd>CopilotChatPrompts<CR>', mode = { 'n', 'v' }, desc = '[C]opilotChat [P]rompts' },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      display = {
        chat = {
          icons = {
            pinned_buffer = ' ',
            watched_buffer = '👀 ',
          },
          debug_window = {
            width = vim.o.columns - 5,
            height = vim.o.lines - 2,
          },
          window = {
            layout = 'vertical', -- float|vertical|horizontal|buffer
            position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
            border = 'single',
            height = 0.8,
            width = 0.45,
            relative = 'editor',
            full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
            opts = {
              breakindent = true,
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = '0',
              linebreak = true,
              list = false,
              numberwidth = 1,
              signcolumn = 'no',
              spell = false,
              wrap = true,
            },
          },

          token_count = function(tokens, adapter)
            return ' (' .. tokens .. ' tokens)'
          end,
        },
        action_palette = {
          width = 95,
          height = 10,
          prompt = 'Prompt ',
          provider = 'default',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
      },
    },
    keys = {
      { '<leader>cca', '<cmd>CodeCompanionActions<CR>', desc = 'CodeCompanion Actions' },
      { '<leader>ccc', '<cmd>CodeCompanionChat Toggle<CR>', desc = 'CodeCompanion Chat' },
    },
  },
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    version = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'github/copilot.vim',
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
    },
    opts = {
      provider = 'copilot',
      selector = {
        provider = 'snacks',
      },
      behaviour = {
        enable_cursor_planning_mode = false,
        enable_claude_text_editor_tool_mode = true,
      },
    },
  },
}
