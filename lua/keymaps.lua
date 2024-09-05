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
map('n', '<Leader>a', ':Ag ')
map('n', '<Leader>f', ':Files<CR>')
map('n', '<Leader>s', 'yaw :Ag <C-R>"<CR>')
map('n', '<Leader>b', ':Buffers<CR>')
map('n', '<Leader>v', ':VerticalSplit<CR><C-w><C-w>')
map('n', '<Leader>h', ':HorizontalSplit<CR>')
map('n', '<Leader>x', ':KillOtherBuffers<CR>')
map('n', '<Leader>r', ':SReplace<CR>')
map('n', '<Leader>k', ':CloseBuffer<CR>')
map('n', '<Leader>g', ':GitGutterNextHunk<CR>')
map('n', '<Leader>gp', ':GitGutterPreviewHunk<CR>')
map('n', '<Leader>gu', ':GitGutterUndoHunk<CR>')
map('n', '<Leader>t', ':VerticalSplit<CR><C-w><C-w><bar>:terminal<CR>')
map('n', '<Leader>q', ':cclose<CR>')
map('n', '<Leader>.', ':EditConfig<CR>')
map('n', '<Leader>m', ':Startify<CR>')
map('n', '<Leader>d', ':GoToDefinition<CR>')
map('n', '<Leader><Leader>', ':bnext<CR>')
map('n', 'gd', ':GoToDefinition<CR>')
map('n', 'gr', ':GoToReferences<CR>')
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
map("n", "<Leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<Leader><Up>", "<PageUp>", { desc = "Move 10 lines up" })
map("n", "<Leader><Down>", "<PageDown>", { desc = "Move 10 lines down" })
