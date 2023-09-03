local lspformat = require('lsp-format')
local lspconfig = require('lspconfig')

lspformat.setup {}

local on_attach = function(client, _)
  lspformat.on_attach(client)
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
    'solargraph',
    'lua_ls'
  }
})


lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,

}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim"
        }
      }
    }
  }
}

lspconfig.elixirls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    elixirLS = {
      mixTarget = 'dev',
      dialyzerEnabled = false,
      fetchDeps = true
    }
  }
}
