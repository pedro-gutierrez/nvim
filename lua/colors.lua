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

  vim.opt.background = "dark"

  vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none

  " Optional: Set specific UI elements to transparent if needed
  " highlight LineNr guibg=none
  " highlight SignColumn guibg=none
  ]]
else
  vim.cmd [[hi Visual ctermbg=7 ctermfg=none]]
  vim.cmd [[hi SignColumn ctermfg=4 ctermbg=248]]
  vim.cmd [[hi LineNr ctermfg=130 ]]
  vim.cmd [[hi CursorLineNr ctermfg=130]]
  vim.cmd [[hi Statement ctermfg=130 cterm=none]]
  vim.cmd [[hi Comment ctermfg=4]]
  vim.cmd [[hi Identifier ctermfg=6]]
  vim.cmd [[hi Function ctermfg=6]]
  vim.cmd [[hi Type ctermfg=2]]
  vim.cmd [[hi Constant ctermfg=1]]
  vim.cmd [[hi String ctermfg=1]]
  vim.cmd [[hi Operator ctermfg=130]]
  vim.cmd [[hi Special ctermfg=1]]
  vim.cmd [[hi Delimiter ctermfg=5 cterm=none]]
  vim.cmd [[hi MatchParen ctermbg=14 cterm=none]]
  vim.cmd [[hi Directory ctermfg=4]]
  vim.cmd [[hi StatusLineNC cterm=reverse]]
  vim.cmd [[hi QuickFixLine ctermbg=11 ctermfg=none]]
  vim.cmd [[hi Title ctermfg=5 cterm=none]]
  vim.cmd [[hi Pmenu ctermfg=0 ctermbg=225 cterm=none]]
  vim.cmd [[hi PmenuSel ctermfg=0 ctermbg=7 cterm=none]]
  vim.cmd [[hi NormalFloat ctermfg=0 ctermbg=225 cterm=none]]
  vim.cmd [[hi Search ctermbg=11 ctermfg=none]]
  vim.cmd [[hi CurSearch ctermbg=11 ctermfg=none]]
end
