-- Also set the following env vars:
-- export FZF_DEFAULT_OPTS="--no-color --no-separator"
-- export FZF_DEFAULT_COMMAND='ag --ignore-dir={.git,deps,_build} -g ""'
vim.g['fzf_preview_window'] = {}
vim.g['fzf_action'] = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit'
}
vim.g['fzf_layout'] = {
  ['down'] = '10'
}
