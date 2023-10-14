require('nvim-search-and-replace').setup({
  ignore = {
    '**/node_modules/**',
    '**/.git/**',
    '**/.gitignore',
    '**/.gitmodules',
    '**/build/**',
    '**/deps/**',
    '**/_build/**'
  }
})
