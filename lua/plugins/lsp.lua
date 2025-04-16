return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'saghen/blink.cmp' },
    },
    cond = function()
      local ft = vim.bo.filetype
      return ft ~= 'dashboard' and ft ~= 'snacks_dashboard'
    end,
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          map('gd', require('snacks').picker.lsp_definitions, '[G]oto [D]efinition')
          map('gD', require('snacks').picker.lsp_declarations, '[G]oto [D]eclaration')
          map('gr', require('snacks').picker.lsp_references, '[G]oto [R]eferences')
          map('gI', require('snacks').picker.lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>cD', require('snacks').picker.lsp_type_definitions, 'Type [D]efinition')
          -- map('<leader>ds', require('snacks').picker.lsp_symbols, '[D]ocument [S]ymbols')
          -- map('<leader>ws', require('snacks').picker.lsp_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>crn', vim.lsp.buf.rename, '[R]ename')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('gH', function()
            vim.lsp.buf.hover { border = 'rounded' }
          end, 'Hover Documentation')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
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

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        ts_ls = {},
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},
        tailwindcss = {},
        eslint = {
          on_attach = function(client, bufnr)
            vim.api.nvim_create_autocmd('BufWritePost', {
              buffer = bufnr,
              command = 'EslintFixAll',
            })
          end,
        },
        dockerls = {},
        docker_compose_language_service = {},
        ansiblels = {},
        -- sqlls = {},

        jsonls = {},
        yamlls = {},

        -- jdtls = {},
        pyright = {},
        rust_analyzer = {},

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

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'eslint', -- Used to lint JavaScript and TypeScript code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          jdtls = function()
            require('java').setup {}

            require('lspconfig').jdtls.setup(servers.jdtls)
          end,
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
