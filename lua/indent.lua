vim.cmd [[highlight IndentBlanklineIndent1 ctermfg=lightgray cterm=none]]

require("ibl").setup {
  exclude = {
    filetypes = { "startify" },
    buftypes = { "terminal" }
  },
  indent = {
    char = "|",
    highlight = {
      "IndentBlanklineIndent1",
    }
  },
  scope = { enabled = false }
}
