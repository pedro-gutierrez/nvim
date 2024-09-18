local map = function(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
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
map('n', '<Leader>h', ':noh<CR>')
map('n', '<Leader>sv', ':VerticalSplit<CR><C-w><C-w>')
map('n', '<Leader>sh', ':HorizontalSplit<CR>')
map('n', '<Leader>x', ':KillOtherBuffers<CR>')
map('n', '<Leader>r', ':SReplace<CR>')
map('n', '<Leader>k', ':CloseBuffer<CR>')
map('n', '<Leader>kq', ':CloseBuffer<CR>:q<CR>')
map('n', '<Leader>g', ':GitGutterNextHunk<CR>')
map('n', '<Leader>gp', ':GitGutterPreviewHunk<CR>')
map('n', '<Leader>gu', ':GitGutterUndoHunk<CR>')
map('n', '<Leader>t', ':VerticalSplit<CR><C-w><C-w><bar>:terminal<CR>')
map('n', '<Leader>q', ':cclose<CR>')
map('n', '<Leader>.', ':EditConfig<CR>')
map('n', '<Leader>m', ':Startify<CR>')
map('n', '<Leader><Leader>', ':bnext<CR>')
map('n', 'gd', ':GoToDefinition<CR>')
map('n', 'gr', ':GoToReferences<CR>')
map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
map("n", "<Leader>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
map("n", "<Leader><Up>", "<PageUp>", { desc = "Move 10 lines up" })
map("n", "<Leader><Down>", "<PageDown>", { desc = "Move 10 lines down" })
map("n", "<Leader>c", ":%GpRewrite ", { desc = "Prompt chat gpt with the current buffer as context" })


local function set_elixir_go_to_definition()
  map('n', '<leader>d', ':OpenDefinition<CR>')
end

-- Function to set the default LSP-based key mapping (for other file types)
local function set_default_go_to_definition()
  map('n', '<leader>d', ':GoToDefinition<CR>')
end

-- Function to set key mappings based on file type
local function set_key_mappings()
  local filetype = vim.bo.filetype
  if filetype == 'elixir' then
    set_elixir_go_to_definition()
  else
    set_default_go_to_definition()
  end
end

-- Apply key mappings when the file type changes
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = set_key_mappings,
})

-- Optionally, set default key mappings on startup
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = set_key_mappings,
})
