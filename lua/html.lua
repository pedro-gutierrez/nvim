local function htmlPreview()
  local file_path = vim.fn.expand('%')
  os.execute("open " .. file_path)
end

vim.api.nvim_create_augroup('HtmlPreview', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.html' },
  callback = htmlPreview,
  group = 'HtmlPreview',
})
