local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


vim.g.mapleader = " "
map('t', '<Esc>', '<C-\\><C-n>')
map('n', ';', ':')
map('n', '<tab><tab>', '<C-w><C-w>')
map('n', '<Leader>p', ':Files<CR>')
map('n', '<Leader>s', ':SearchFiles<CR>')
map('n', '<Leader>f', ':ExploreFiles<CR>')
map('n', '<Leader>b', ':Buffers<CR>')
map('n', '<Leader>v', ':VerticalSplit<CR><C-w><C-w>')
map('n', '<Leader>h', ':HorizontalSplit<CR>')
map('n', '<Leader>x', ':KillOtherBuffers<CR>')
map('n', '<Leader>r', ':SReplace<CR>')
map('n', '<Leader>k', ':KillBuffer<CR>')
map('n', '<Leader>w', ':CloseWindow<CR>')
map('n', '<Leader>g', ':GitGutterNextHunk<CR>')
map('n', '<Leader>gp', ':GitGutterPreviewHunk<CR>')
map('n', '<Leader>t', ':OpenTerminal<CR>')
map('n', '<Leader>q', ':cclose<CR>')
map('n', '<Leader>.', ':EditConfig<CR>')
map('n', '<Leader>m', ':Startify<CR>')
