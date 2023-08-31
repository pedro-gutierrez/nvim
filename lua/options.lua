vim.g.indent_blankline_char = "┊"

local opt = vim.opt
opt.updatetime = 250
opt.background = "light"
opt.hidden = true
opt.number = true
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.backspace = "indent,eol,start"
opt.autoindent = true
opt.copyindent = true
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
opt.shortmess:append("c")
opt.wrap = true
opt.clipboard:append("unnamedplus")
opt.cursorline = true
opt.textwidth = 100
opt.laststatus = 2
opt.timeoutlen = 300
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.mouse = "c"

local win = vim.wo
win.wrap = false
