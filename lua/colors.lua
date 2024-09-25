require('illuminate').configure {}

local function get_terminal()
  return os.getenv("TERM_PROGRAM") or os.getenv("TERM") or ""
end

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
local function get_terminal_profile(term)
  if term == "Apple_Terminal" then
    local result = vim.fn.system("terminal_profile")
    result = vim.trim(result)

    if vim.v.shell_error ~= 0 then
      return ""
    end

    return result
  else
    return ""
  end
end


local term = get_terminal()
local term_profile = get_terminal_profile(term)


vim.g.indent_blankline_char = "┊"
vim.cmd [[set fillchars+=vert:\|]]
vim.cmd [[hi VertSplit cterm=NONE]]
vim.cmd [[hi CursorLine cterm=none term=none gui=none]]
vim.cmd [[hi CursorLineNr cterm=none term=none gui=none]]
vim.cmd [[hi CursorLine ctermbg=none]]
vim.cmd [[hi IlluminatedWordRead cterm=none ctermbg=lightyellow]]
vim.cmd [[hi NonText ctermfg=lightgray cterm=none gui=none]]


--if term == 'Apple_Terminal' and term_profile == 'Pro' then
--  vim.opt.background = "dark"
--  vim.cmd [[
--    colorscheme habamax
--    hi Normal ctermbg=none
--    hi Comment ctermfg=235
--    hi CursorLine ctermbg=none
--    hi StatusLine ctermbg=235 ctermfg=white cterm=bold
--    hi StatusLineNC ctermbg=235 ctermfg=darkgray cterm=bold
--    hi IlluminatedWordRead cterm=underline ctermbg=none
--    hi ErrorMsg cterm=none ctermfg=1 ctermbg=none
--    hi Title ctermfg=darkyellow cterm=none
--    hi SignColumn ctermbg=235
--    hi LineNr ctermfg=235
--    hi GitGutterAdd ctermfg=green
--    hi GitGutterChange ctermfg=darkyellow
--    hi GitGutterDelete ctermfg=1
--    hi WinSeparator ctermbg=none ctermfg=235
--    hi @markup.raw.markdown_inline ctermfg=lightred
--    hi fzf1 ctermbg=235
--    hi fzf2 ctermbg=235
--    hi fzf3 ctermbg=235
--  ]]
--end

if term == 'Apple_Terminal' and term_profile == 'Basic' then
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

if term == "xterm-kitty" or term == 'iTerm.app' or term_profile == 'Pro' then
  vim.opt.background = "dark"
  vim.cmd [[
      hi CursorLine guibg=none ctermbg=none
      hi SignColumn guibg=NvimDarkGray3 ctermbg=none
      hi LineNr guifg=NvimDarkGray4 ctermfg=darkgray
      hi WinSeparator guifg=NvimDarkGray4 ctermfg=darkgray
      hi StatusLine guibg=none guifg=NvimLightGray3 ctermfg=lightgray cterm=none
      hi StatusLineNC guibg=none guifg=NvimDarkGray4 ctermfg=darkgray cterm=none
      hi Title guifg=NvimLightGray3 ctermfg=lightgray
      hi Comment ctermfg=darkgray
      hi Statement cterm=bold ctermfg=lightgray
      hi IlluminatedWordRead cterm=underline ctermbg=none
      hi Type ctermfg=lightgray
      hi Operator ctermfg=lightgray
      hi Constant ctermfg=lightgray
      hi Identifier ctermfg=117
      hi String ctermfg=lightgreen
      hi Function ctermfg=cyan
      hi Pmenu ctermbg=darkgray cterm=none
      hi visual ctermbg=lightgray
      hi GitGutterAdd ctermfg=darkgreen
      hi GitGutterChange ctermfg=darkyellow
      hi GitGutterDelete ctermfg=red
      hi fzf1 ctermbg=none cterm=none
      hi fzf2 ctermbg=none cterm=none
      hi fzf3 ctermbg=none cterm=none
      hi Special ctermfg=117
    ]]
end
