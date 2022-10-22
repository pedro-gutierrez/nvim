local execute = vim.api.nvim_command
local fn = vim.fn

vim.env.FZF_DEFAULT_OPTS = '--no-color'

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

vim.g.indent_blankline_char = "┊"

local opt = vim.opt
opt.updatetime = 250
opt.background = "light"
opt.hidden = true
opt.number = true
opt.tabstop = 8
opt.backspace = "indent,eol,start"
opt.autoindent = true
opt.copyindent = true
opt.shiftwidth = 4
opt.shiftround = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.smarttab = true
opt.hlsearch = true
opt.incsearch = true
opt.history = 1000
opt.undolevels = 1000
opt.wildignore = "*.swp,*.bak,*.pyc,*.class"
opt.title = true
opt.visualbell = true
opt.errorbells = false
opt.backup = false
opt.swapfile = false
opt.softtabstop = 4
opt.expandtab = true
opt.shortmess:append("c")
opt.wrap = true
opt.clipboard = "unnamed"
opt.cursorline = true
opt.textwidth = 120
opt.laststatus = 2
opt.timeoutlen = 300

local win = vim.wo
win.wrap = false

vim.cmd [[hi VertSplit cterm=NONE]]
vim.cmd [[set fillchars+=vert:\|]]
vim.cmd [[hi CursorLine cterm=none term=none]]
vim.cmd [[hi CursorLineNr cterm=none term=none]]
vim.cmd [[hi CursorLine ctermbg=none]]

vim.cmd [[hi fzf1 ctermbg=black ctermfg=white]]
vim.cmd [[hi fzf2 ctermbg=black ctermfg=white]]
vim.cmd [[hi fzf3 ctermbg=black ctermfg=white]]

vim.cmd [[autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete]]
vim.cmd [[autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab]]
vim.cmd [[autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab]]
vim.cmd [[autocmd FileType elixir setlocal ts=2 sts=2 sw=2 expandtab]]

vim.cmd [[tnoremap <Esc> <C-\><C-n>]]
vim.cmd [[autocmd TermOpen * set nonu]]
vim.cmd [[autocmd TermOpen * startinsert]]
vim.cmd [[noremap <tab><tab> <C-w><C-w>]]
vim.cmd [[nnoremap ; :]]
vim.cmd [[nmap <silent> ,/ :nohlsearch<CR>]]
vim.cmd [[command! EditConfig edit ~/.config/nvim/init.lua]]
vim.cmd [[command! KillBuffer bd!]]
vim.cmd [[command! KillOtherBuffers %bdelete!|edit #|normal `"]]
vim.cmd [[command! VerticalSplit vsplit]]
vim.cmd [[command! HorizontalSplit split]]
vim.cmd [[command! OpenTerminal term]]
vim.cmd [[command! ExploreFiles Sexplore]]
vim.cmd [[command! SearchFiles Ag]]

vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<Leader>p', ':Files<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':SearchFiles<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>f', ':ExploreFiles<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>v', ':VerticalSplit<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>h', ':HorizontalSplit<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>x', ':KillOtherBuffers<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':SReplace<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>k', ':KillBuffer<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>g', ':GitGutterNextHunk<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':OpenTerminal<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':TroubleClose<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>.', ':EditConfig<CR>', {noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>m', ':Startify<CR>', {noremap = true })


local startup = require("packer").startup

startup(function(use)

    use "airblade/vim-rooter"
    use "williamboman/nvim-lsp-installer"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-compe"
    use "hrsh7th/vim-vsnip"
    use "hrsh7th/vim-vsnip-integ"
    use "nvim-treesitter/nvim-treesitter"
    use "junegunn/fzf"
    use "junegunn/fzf.vim"
    use "ojroques/nvim-lspfuzzy"
    use "brooth/far.vim"
    use "tpope/vim-fugitive"
    use "airblade/vim-gitgutter"
    use "ntpeters/vim-better-whitespace"
    use "rust-lang/rust.vim"
    use "fatih/vim-go"
    use "mhinz/vim-startify"
    use 'pedro-gutierrez/nvim-hardline'
    use 's1n7ax/nvim-search-and-replace'

    require('hardline').setup {}
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

    vim.g['gitgutter_map_keys'] = 0
    vim.g['gitgutter_override_sign_column_highlight'] = 0
    -- vim.cmd [[highlight clear SignColumn]]
    vim.cmd [[highlight GitGutterAdd ctermfg=2]]
    vim.cmd [[highlight GitGutterChange ctermfg=3]]
    vim.cmd [[highlight GitGutterDelete ctermfg=1]]
    vim.cmd [[highlight GitGutterChangeDelete ctermfg=4]]


   vim.g['fzf_preview_window'] = {}
   vim.g['fzf_action'] = {
     ['ctrl-t'] = 'tab split',
     ['ctrl-s'] = 'split',
     ['ctrl-v'] = 'vsplit'
   }
   vim.g['fzf_layout'] = {
     ['down'] = '10'
   }

   use {
     "folke/trouble.nvim",
     -- requires = "kyazdani42/nvim-web-devicons",
     config = function()
       require("trouble").setup {
         icons = false,
         auto_open = true,
         auto_close = true,
         fold_open = "v",
         fold_closed = ">",
         indent_lines = false,
         signs = {
           error = "[error]",
           warning = "[warn]",
           hint = "[hint]",
           information = "[info]"
         }
       }
     end
   }

   require'nvim-treesitter.configs'.setup {
         ensure_installed = { "elixir", "erlang", "go", "python", "json", "javascript", "yaml", "hcl" },
         highlight = { enable = true },
         indent = { enable = true },
         incremental_selection = { enable = true },
         textobjects = { enable = false },
   }

   vim.cmd [[highlight! link TSSymbol TSConstant]]

   local lspconfig = require("lspconfig")
   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities.textDocument.completion.completionItem.snippetSupport = true

     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
         vim.lsp.diagnostic.on_publish_diagnostics, {
             underline = false,
             virtual_text =  false,
             signs = true,
             update_in_insert = true
         }
     )

   require "compe".setup {
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 1,
        preselect = "disabled",
        throttle_time = 80,
        source_timeout = 200,
        incomplete_delay = 400,
        max_abbr_width = 100,
        max_kind_width = 100,
        max_menu_width = 100,
        documentation = true,
        source = {
            path = true,
            buffer = true,
            calc = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            treesitter = true
        }
   }

   local on_attach = function(_, bufnr)
    local map_opts = {noremap = true, silent = true}

        vim.api.nvim_buf_set_keymap(bufnr, "n", "df", "<cmd>lua vim.lsp.buf.formatting()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gld", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.implementation()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", map_opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<cr>", map_opts)

        vim.cmd [[inoremap <silent><expr> <C-Space> compe#complete()]]
        vim.cmd [[inoremap <silent><expr> <CR> compe#confirm('<CR>')]]
        vim.cmd [[inoremap <silent><expr> <C-e> compe#close('<C-e>')]]
        vim.cmd [[inoremap <silent><expr> <C-f> compe#scroll({ 'delta': +4 })]]
        vim.cmd [[inoremap <silent><expr> <C-d> compe#scroll({ 'delta': -4 })]]

        vim.api.nvim_command [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
        -- vim.api.nvim_command [[autocmd CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics()]]
   end

    lspconfig.elixirls.setup({
        cmd = { vim.fn.expand('~/Projects/elixir-ls/language_server.sh') },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            elixirLS = {
                mixTarget = 'dev',
                dialyzerEnabled = false,
                fetchDeps = false
            }
        }
    })

    vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
    vim.cmd([[autocmd BufRead,BufNewFile *.hcl set filetype=hcl]])
    vim.cmd([[autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl]])
    vim.cmd([[autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform]])
    vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])
    vim.cmd([[let g:terraform_fmt_on_save=1]])
    vim.cmd([[let g:terraform_align=1]])

    require'lspconfig'.terraformls.setup{}
    require'lspconfig'.tflint.setup{}

    -- Remove trailing whitespaces from files before saving
    vim.api.nvim_create_autocmd({ "BufWritePre" }, {
        pattern = { "*" },
        command = [[%s/\s\+$//e]],
    })
end)
