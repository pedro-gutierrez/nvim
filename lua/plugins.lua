--
-- Packer initial installation:
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
  use 'ahmedkhalf/project.nvim'
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "lukas-reineke/lsp-format.nvim"
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
  use 'ray-x/cmp-treesitter'
  use 'L3MON4D3/LuaSnip'
  use 'navarasu/onedark.nvim'
  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use 'rrethy/vim-illuminate'
end)
