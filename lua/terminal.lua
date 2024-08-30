-- If you want your terminals to always be in the insert mode when you click the pane with your
-- mouse
--vim.api.nvim_command "augroup terminal_setup | au!"
--vim.api.nvim_command "autocmd TermOpen * nnoremap <buffer><LeftRelease> <LeftRelease>i"
--vim.api.nvim_command "augroup end"

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    if vim.opt.buftype:get() == "terminal" then
      vim.cmd(":startinsert")
    end
  end
})

--require('toggleterm').setup({
--  direction = 'vertical',
--  size = 60,
--  start_in_insert = true,
--  persist_mode = false
--})
