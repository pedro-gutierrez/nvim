if os.getenv("TERM_PROGRAM") == "iTerm.app" then

  -- setup one dark color scheme
  require('onedark').setup({
    code_style = {
      comments = 'none',
    }
  })

  require('onedark').load()
  vim.cmd [[ set background=dark ]]
  vim.cmd [[ colorscheme onedark ]]

  -- illuminate by highlighting text in bold
  vim.cmd [[hi IlluminatedWordRead cterm=bold ctermbg=none]]

  -- lualine one dark config
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'onedark'
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
    },
  }
end
