return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      -- 'hrsh7th/cmp-nvim-lsp',
      -- 'hrsh7th/cmp-cmdline',
      { 'nvim-java/nvim-java' },
      -- { 'pmizio/typescript-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }, opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Set vim motion for <Space> + c + h to show code documentation about the code the cursor is currently over if available
          vim.keymap.set('n', '<leader>ch', vim.lsp.buf.hover, { desc = '[C]ode [H]over Documentation' })
          -- Set vim motion for <Space> + c + d to go where the code/variable under the cursor was defined
          vim.keymap.set('n', '<leader>cd', vim.lsp.buf.definition, { desc = '[C]ode Goto [D]efinition' })
          -- Set vim motion for <Space> + c + a for display code action suggestions for code diagnostics in both normal and visual mode
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [A]ctions' })
          -- Set vim motion for <Space> + c + r to display references to the code under the cursor
          vim.keymap.set('n', '<leader>cr', require('telescope.builtin').lsp_references, { desc = '[C]ode Goto [R]eferences' })
          -- Set vim motion for <Space> + c + i to display implementations to the code under the cursor
          vim.keymap.set('n', '<leader>ci', require('telescope.builtin').lsp_implementations, { desc = '[C]ode Goto [I]mplementations' })
          -- Set a vim motion for <Space> + c + <Shift>R to smartly rename the code under the cursor
          vim.keymap.set('n', '<leader>cR', vim.lsp.buf.rename, { desc = '[C]ode [R]ename' })
          -- Set a vim motion for <Space> + c + <Shift>D to go to where the code/object was declared in the project (class file)
          vim.keymap.set('n', '<leader>cD', vim.lsp.buf.declaration, { desc = '[C]ode Goto [D]eclaration' })

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            vim.keymap.set('n', '<leader>cth', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, { desc = '[C]ode [T]oggle Inlay [H]ints' })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        ts_ls = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},
        tailwindcss = {},
        -- dockerls = {},
        -- sqlls = {},

        jsonls = {},
        -- yamlls = {},

        -- jdtls = {},
        pyright = {},

        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              diagnostics = { disable = { 'missing-fields' } },
              format = {
                enable = false,
              },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          jdtls = function()
            require('java').setup {
              -- Your custom jdtls settings goes here
            }

            require('lspconfig').jdtls.setup(servers.jdtls)
          end,
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
