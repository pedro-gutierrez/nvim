if os.getenv("TERM_PROGRAM") == "iTerm.app" then

  -- setup one dark color scheme
  require('onedark').setup({
    transparent = true,
    code_style = {
      comments = 'none',
    }
  })

  require('onedark').load()
  vim.cmd [[ set background=dark ]]
  --vim.cmd [[ colorscheme onedark ]]

  require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = false,
    italic = {
      strings = false,
      comments = false,
      operators = false,
      folds = false,
    },
    strikethrough = true,
    invert_selection = true,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = false, -- invert background for search, diffs, statuslines and errors
    contrast = "hard", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = true,
  })



  vim.cmd [[ colorscheme gruvbox ]]


  -- illuminate by highlighting text in bold
  vim.cmd [[hi IlluminatedWordRead cterm=bold ctermbg=none]]

  -- lualine one dark config
  require('lualine').setup {
    options = {
      icons_enabled = false,
      theme = 'gruvbox'
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
