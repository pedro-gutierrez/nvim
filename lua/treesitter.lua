require'nvim-treesitter.configs'.setup {
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
  textobjects = { enable = false },
}

vim.cmd [[highlight! link TSSymbol TSConstant]]
