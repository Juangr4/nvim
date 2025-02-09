return {
  'mfussenegger/nvim-dap',
  enabled = false,
  dependencies = {
    'rcarriga/nvim-dap-ui',
    -- 'mxsdev/nvim-dap-vscode-js',
  },
  config = function()
    local dap, dapui = require 'dap', require 'dapui'

    dapui.setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- require('dap-vscode-js').setup {
    --   adapters = { 'pwa-node' },
    -- }
    --
    -- for _, lang in ipairs { 'javascript', 'typescript' } do
    --   dap.configurations[lang] = {
    --     {
    --       type = 'pwa-node',
    --       request = 'launch',
    --       name = 'Debug Jest Tests',
    --       -- trace = true, -- include debugger info
    --       runtimeExecutable = 'node',
    --       runtimeArgs = {
    --         './node_modules/jest/bin/jest.js',
    --         '--runInBand',
    --       },
    --       rootPath = '${workspaceFolder}',
    --       cwd = '${workspaceFolder}',
    --       console = 'integratedTerminal',
    --       internalConsoleOptions = 'neverOpen',
    --     },
    --   }
    -- end

    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
  end,
}
