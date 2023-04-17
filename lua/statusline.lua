local normal = { bg = 'black', fg = 'white' }
local bold = { bg = 'black', fg = 'white', gui = 'bold' }
local default = { a = bold, b = normal, c = normal, x = normal, y = normal, z = normal }

require('lualine').setup {
  extensions = { 'quickfix', 'fzf' },
  options = {
    icons_enabled = false,
    theme = {
      normal = default,
      insert = default,
      visual = default,
      replace = default,
      command = default,
      inactive = default
    },
    section_separators = '',
    component_separators = ''
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress', 'diff', 'diagnostics' },
    lualine_z = { 'location' }
  },
}
