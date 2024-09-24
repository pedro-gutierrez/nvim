require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "elixir",
    "eex",
    "heex",
    "erlang",
    "go",
    "python",
    "json",
    "javascript",
    "yaml",
    "ruby",
    "liquid",
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
}

--vim.api.nvim_set_hl(0, "@variable", { link = "None" })
--vim.api.nvim_set_hl(0, "@symbol", { link = "Constant" })
--vim.api.nvim_set_hl(0, "@module", { link = "Type" })
