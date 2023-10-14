require('illuminate').configure {}

vim.g.indent_blankline_char = "┊"
vim.cmd [[set fillchars+=vert:\|]]
vim.cmd [[hi VertSplit cterm=NONE]]
vim.cmd [[hi CursorLine cterm=none term=none]]
vim.cmd [[hi CursorLineNr cterm=none term=none]]
vim.cmd [[hi CursorLine ctermbg=none]]
vim.cmd [[hi IlluminatedWordRead cterm=none ctermbg=lightyellow]]
vim.cmd [[hi NonText ctermfg=lightgray cterm=none gui=none]]

-- overrides for terminals I use in dark mode
if os.getenv("TERM_PROGRAM") ~= "Apple_Terminal" then
  vim.opt.background = "dark"
  vim.cmd [[hi SignColumn ctermbg=none guibg=none]]
  vim.cmd [[hi IlluminatedWordRead cterm=bold ctermbg=none gui=underline]]
  vim.cmd [[hi NonText cterm=none gui=none]]
  require('onedark').load()
end
