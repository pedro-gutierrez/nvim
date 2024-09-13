require('illuminate').configure {}

-- Here is the source of the `terminal_profile` script
--#!/bin/bash
--current_profile=$(osascript -e '
--tell application "Terminal"
--    set currentTab to selected tab of front window
--    set profileName to name of current settings of currentTab
--end tell
--return profileName
--')
--
--echo "$current_profile"
local function get_terminal_profile()
  local result = vim.fn.system("terminal_profile")
  result = vim.trim(result)

  if vim.v.shell_error ~= 0 then
    return "Basic"
  end

  return result
end

local function use_dark_theme()
  return os.getenv("TERM_PROGRAM") ~= "Apple_Terminal" or get_terminal_profile() ~= "Basic"
end

vim.g.indent_blankline_char = "┊"
vim.cmd [[set fillchars+=vert:\|]]
vim.cmd [[hi VertSplit cterm=NONE]]
vim.cmd [[hi CursorLine cterm=none term=none gui=none]]
vim.cmd [[hi CursorLineNr cterm=none term=none gui=none]]
vim.cmd [[hi CursorLine ctermbg=none]]
vim.cmd [[hi IlluminatedWordRead cterm=none ctermbg=lightyellow]]
vim.cmd [[hi NonText ctermfg=lightgray cterm=none gui=none]]


if use_dark_theme() then
  vim.opt.background = "dark"
  vim.cmd [[
    colorscheme quiet
    hi SignColumn ctermbg=none
    hi CursorLine cterm=none ctermbg=none gui=none
    hi Function ctermfg=gray
    hi Identifier ctermfg=white
    hi Delimiter ctermfg=darkgray
    hi Special ctermfg=lightgray
    hi Statement ctermfg=gray
    hi Type ctermfg=gray
    hi Constant ctermfg=8
    hi Operator ctermfg=darkgray
    hi @module.elixir ctermfg=white
    hi @variable.elixir ctermfg=lightgray
    hi Search ctermbg=darkgray
    hi IlluminatedWordRead cterm=underline ctermbg=none
    hi MatchParen ctermbg=lightgray cterm=none ctermfg=none
    hi Visual ctermbg=white ctermfg=darkgray
    hi StatusLine ctermbg=white ctermfg=black cterm=none
    hi StatusLineNC ctermbg=white ctermfg=black cterm=none
    hi ErrorMsg cterm=none ctermfg=1 ctermbg=none
    hi Directory ctermfg=gray cterm=bold
    hi Title ctermfg=darkgray cterm=none
    hi QuickFixLine ctermbg=none ctermfg=gray cterm=none
    hi Search ctermbg=darkgray ctermfg=none cterm=none
    hi CurSearch ctermbg=lightyellow ctermfg=none cterm=none
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
