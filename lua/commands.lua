local function close_buffer()
  -- Get the current buffer number
  local bufnr = vim.api.nvim_get_current_buf()

  -- Check if the buffer is modified (has unsaved changes)
  if vim.api.nvim_buf_get_option(bufnr, 'modified') then
    -- Display a custom error message if there are unsaved changes
    vim.api.nvim_err_writeln('Error: Buffer has unsaved changes. Please save or discard changes before closing.')
    return
  end

  -- Get a list of all windows displaying this buffer
  local wins = vim.fn.getbufinfo(bufnr)[1].windows

  -- If there is only one window showing the buffer, create a new empty buffer first
  if #wins == 1 then
    vim.cmd('enew')              -- Create a new empty buffer
    vim.cmd('bdelete ' .. bufnr) -- Delete the original buffer
  else
    -- Close the buffer without closing the window by using :bdelete
    vim.cmd('bdelete ' .. bufnr)
  end
end


vim.api.nvim_create_user_command('CloseBuffer', close_buffer, {})

vim.cmd [[autocmd BufWritePre * %s/\s\+$//e]]
vim.cmd [[autocmd TermOpen * set nonu]]
vim.cmd [[autocmd TermOpen * startinsert]]
vim.cmd [[autocmd TermOpen * :DisableWhitespace]]
vim.cmd [[command! EditConfig edit ~/.config/nvim/init.lua]]
vim.cmd [[command! CloseWindow q]]
vim.cmd [[command! KillBuffer bd!]]
vim.cmd [[command! KillOtherBuffers %bdelete!|edit #|normal `"]]
vim.cmd [[command! VerticalSplit vsplit]]
vim.cmd [[command! HorizontalSplit split]]
vim.cmd [[command! OpenTerminal term]]
vim.cmd [[command! ExploreFiles Sexplore]]
vim.cmd [[command! SearchFiles Ag]]
vim.cmd [[command! GoToDefinition lua vim.lsp.buf.definition()]]
vim.cmd [[command! GoToReferences lua vim.lsp.buf.references()]]
vim.cmd [[command! FormatJson :%!jq .]]
vim.cmd [[command! LspClearLog :! rm /Users/pedrogutierrez/.local/state/nvim/lsp.log]]
vim.cmd [[command! LspClearElixirLs :! rm -rf .elixir_ls]]
vim.cmd [[command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--ignore-dir={_build,deps}', fzf#vim#with_preview(), <bang>0)]]
