require("indent_blankline").setup {
  buftype_exclude = { "terminal", "startify" },
  filetype_exclude = { 'help', 'packer', 'startify', 'alpha' },
  char_highlight_list = {
    "IndentBlanklineIndent1",
  },
}

vim.cmd [[highlight IndentBlanklineIndent1 ctermfg=lightgray cterm=none]]
