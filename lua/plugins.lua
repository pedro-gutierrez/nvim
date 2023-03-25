--
-- Packer initial installation:
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'ahmedkhalf/project.nvim'
  use "junnplus/lsp-setup.nvim"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "junegunn/fzf"
  use "junegunn/fzf.vim"
  use "airblade/vim-gitgutter"
  use "ntpeters/vim-better-whitespace"
  use "mhinz/vim-startify"
  use 's1n7ax/nvim-search-and-replace'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'

  use { 'nvim-treesitter/nvim-treesitter',
    commit = 'addc129a4f272aba0834bd0a7b6bd4ad5d8c801b',
    lock = true,
    run = ':TSUpdate' }

  require("project_nvim").setup {}

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

  -- illuminate
  use 'rrethy/vim-illuminate'
  require('illuminate').configure {}

  -- testing
  use 'vim-test/vim-test'
  vim.g['test#strategy'] = 'neovim'
  vim.g['test#neovim#term_position'] = 'bot'


  -- these will only be used by my iterm
  use 'navarasu/onedark.nvim'
  use 'nvim-lualine/lualine.nvim'
end)
