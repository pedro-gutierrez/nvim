--
-- Packer initial installation:
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim \
--    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
--
-- Markdown preview initial installation:
-- export NODE_OPTIONS=--openssl-legacy-provider
-- cd ~/.local/share/nvim/site/pack/packer/start/
-- git clone https://github.com/iamcco/markdown-preview.nvim.git
-- cd markdown-preview.nvim
-- npx --yes yarn install
-- npx --yes yarn build
return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'tpope/vim-fugitive'
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
  use 'iamcco/markdown-preview.nvim'

  use 'stevearc/oil.nvim'
  use 'notjedi/nvim-rooter.lua'

  -- Requires the following git editor config setting
  -- [core]
  --   editor = ~/.nvim/0.10.1/bin/nvim --cmd 'let g:unception_block_while_host_edits=1'
  use "samjwill/nvim-unception"

  use "robitx/gp.nvim"
end)
