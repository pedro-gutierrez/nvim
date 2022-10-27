local on_attach = function(client, _)
  require('lsp-setup.utils').format_on_save(client)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local h = 'textDocument/publishDiagnostics'
vim.lsp.handlers[h] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = true
})

function Quickfixlist()
  local current = vim.api.nvim_get_current_win()
  vim.diagnostic.setqflist()
  vim.cmd('cwindow')
  if next(vim.diagnostic.get()) then
    vim.fn.win_gotoid(current)
  end
end

vim.cmd [[autocmd DiagnosticChanged * :lua Quickfixlist()]]

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
