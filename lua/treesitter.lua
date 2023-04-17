require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "elixir",
    "erlang",
    "go",
    "python",
    "json",
    "javascript",
    "yaml",
    "hcl",
    "ruby"
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

vim.api.nvim_set_hl(0, "@variable.elixir", { link = "None" })
vim.api.nvim_set_hl(0, "@symbol.elixir", { link = "String" })
-- vim.cmd [[highlight! link TSSymbol TSConstant]]
