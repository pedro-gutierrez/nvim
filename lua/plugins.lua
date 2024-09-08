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

  use({
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
  })
  use 'rrethy/vim-illuminate'

  --- Project management
  use 'stevearc/oil.nvim'
  use 'notjedi/nvim-rooter.lua'

  -- Run neovim from inside a neovim terminal
  -- Requires the following git editor config setting
  -- [core]
  --   editor = ~/.nvim/0.10.1/bin/nvim --cmd 'let g:unception_block_while_host_edits=1'
  use "samjwill/nvim-unception"

  -- Markdown
  use 'iamcco/markdown-preview.nvim'

  use({
    'MeanderingProgrammer/render-markdown.nvim',
    after = { 'nvim-treesitter' },
    requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
    -- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
    -- requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        file_types = { "markdown", "Avante" }
      })
      require('render-markdown').enable()
    end,
  })

  -- AI plugins and their dependencies
  use "robitx/gp.nvim"
  use {
    'yetone/avante.nvim',
    requires = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "zbirenbaum/copilot.lua"

    },
    build = function()
      vim.cmd('!cd ~/.local/share/nvim/site/pack/packer/start/avante.nvim && make')
    end,
    config = function()
      require('avante').setup()
    end
  }

  -- dark colorschemes
  use 'navarasu/onedark.nvim'
  use 'rose-pine/neovim'
end)
