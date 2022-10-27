local on_attach = function(client, _)
  require('lsp-setup.utils').format_on_save(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = true,
  update_in_insert = true
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'elixirls',
    'sorbet',
  }
})

require('lsp-setup').setup({
  default_mappings = true,
  on_attach = on_attach,
  capabilities = capabilities,
  servers = {
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    },
    elixirls = {
      settings = {
        elixirLS = {
          mixTarget = 'dev',
          dialyzerEnabled = false,
          fetchDeps = false
        }
      }
    }
  }
})
