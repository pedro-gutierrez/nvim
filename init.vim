"" Installing VimPlug for the first time
"" https://github.com/junegunn/vim-plug#neovim

call plug#begin()
Plug 'airblade/vim-rooter'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', {'commit': 'addc129a4f272aba0834bd0a7b6bd4ad5d8c801b'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mhinz/vim-startify'
Plug 'pedro-gutierrez/nvim-hardline'
Plug 's1n7ax/nvim-search-and-replace'
call plug#end()

let g:indent_blankline_char = '┊'

set updatetime=250
set background=light
set hidden
set number
set tabstop=8
set backspace=indent,eol,start
set autoindent
set copyindent
set shiftwidth=4
set shiftround
set showmatch
set ignorecase
set smartcase
set smarttab
set hlsearch
set incsearch
set history=1000
set undolevels=1000
set wildignore='*.swp,*.bak,*.pyc,*.class'
set title
set visualbell
set errorbells
set nobackup
set noswapfile
set softtabstop=4
set expandtab
set shortmess+=c
set wrap
set clipboard=unnamed
set cursorline
set textwidth=120
set laststatus=2
set timeoutlen=300
set lazyredraw


hi VertSplit cterm=NONE
set fillchars+=vert:\|
hi CursorLine cterm=none term=none
hi CursorLineNr cterm=none term=none
hi CursorLine ctermbg=none
"

hi fzf1 ctermbg=black ctermfg=white
hi fzf2 ctermbg=black ctermfg=white
hi fzf3 ctermbg=black ctermfg=white

autocmd FileType * autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType lua setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType elixir setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType elixir setlocal makeprg=mix\ compile\ --warnings-as-errors
autocmd FileType elixir setlocal errorformat=\%C%f:%l
autocmd FileType elixir setlocal errorformat+=\%E==\ Compilation\ error\ in\ file\ %f\ ==
autocmd FileType elixir setlocal errorformat+=\%Wwarning:\ %m
autocmd FileType elixir setlocal errorformat+=%Z%f:%l:
autocmd FileType elixir setlocal errorformat+=%Z\ \ %f:%l
autocmd FileType elixir setlocal errorformat+=%Z\ \ %f:%l:%.%#
autocmd FileType elixir setlocal errorformat+=\%C**\ (%\\w%\\+)\ %f:%l:\ %m
autocmd FileType elixir setlocal errorformat+=\%C**\ (%\\w%\\+)\ %m
autocmd FileType elixir setlocal errorformat+=%-G%.%#
autocmd FileType elixir autocmd BufWritePre <buffer> %!mix format -
autocmd FileType elixir autocmd BufWritePost <buffer> silent make

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

tnoremap <Esc> <C-\><C-n>
autocmd TermOpen * set nonu
autocmd TermOpen * startinsert
autocmd TermOpen * :DisableWhitespace
autocmd TermClose * call feedkeys("i")
noremap <tab><tab> <C-w><C-w>
nnoremap ; :
nmap <silent> ,/ :nohlsearch<CR>
command! EditConfig edit ~/.config/nvim/init.lua
command! CloseWindow q
command! KillBuffer bd!
command! KillOtherBuffers %bdelete!|edit #|normal `"
command! VerticalSplit vsplit
command! HorizontalSplit split
command! OpenTerminal term
command! ExploreFiles Sexplore
command! SearchFiles Ag

let mapleader=' '

nnoremap <Leader>p :Files<CR>
nnoremap <Leader>s :SearchFiles<CR>
nnoremap <Leader>f :ExploreFiles<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>v :VerticalSplit<CR><C-w><C-w>
nnoremap <Leader>h :HorizontalSplit<CR>
nnoremap <Leader>x :KillOtherBuffers<CR>
nnoremap <Leader>r :SReplace<CR>
nnoremap <Leader>k :KillBuffer<CR>
nnoremap <Leader>w :CloseWindow<CR>
nnoremap <Leader>g :GitGutterNextHunk<CR>
nnoremap <Leader>gp :GitGutterPreviewHunk<CR>
nnoremap <Leader>t :OpenTerminal<CR>
nnoremap <Leader>q :TroubleClose<CR>
nnoremap <Leader>. :EditConfig<CR>
nnoremap <Leader>m :Startify<CR>

let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
hi GitGutterAdd ctermfg=2
hi GitGutterChange ctermfg=3
hi GitGutterDelete ctermfg=1
hi GitGutterChangeDelete ctermfg=4


let g:fzf_preview_window = {}
let g:fzf_layout = { 'down': '10'}

lua <<EOF
require('hardline').setup {}
require('nvim-search-and-replace').setup {
    ignore = {
        '**/node_modules/**',
        '**/.git/**',
        '**/.gitignore',
        '**/.gitmodules',
        '**/build/**',
        '**/deps/**',
        '**/_build/**'
    }
}

require'nvim-treesitter.configs'.setup {
    ensure_installed = { "elixir", "erlang", "go", "python", "json", "javascript", "yaml", "hcl" },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = false },
}

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
EOF

hi! link TSSymbol TSConstant
