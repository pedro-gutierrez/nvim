require("ibl").setup {
  exclude = {
    filetypes = { "startify" },
    buftypes = { "terminal" }
  },
  indent = {
    char = "|",
    highlight = {
      "NonText",
    }
  },
  scope = { enabled = false }
}
