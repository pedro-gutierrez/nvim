vim.g['gitgutter_map_keys'] = 0
vim.g['gitgutter_override_sign_column_highlight'] = 0

vim.cmd [[hi GitGutterAdd ctermfg=2]]
vim.cmd [[hi GitGutterChange ctermfg=3]]
vim.cmd [[hi GitGutterDelete ctermfg=1]]
vim.cmd [[hi GitGutterChangeDelete ctermfg=4]]
vim.cmd [[hi fzf1 ctermbg=black ctermfg=white]]
vim.cmd [[hi fzf2 ctermbg=black ctermfg=white]]
vim.cmd [[hi fzf3 ctermbg=black ctermfg=white]]

vim.cmd [[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
