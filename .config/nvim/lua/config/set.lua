-- Choose leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spelling checks
vim.o.spell = false

-- Enable break indent
vim.o.breakindent = true

-- Wrap lines
vim.o.wrap = true

-- Highlight line
vim.o.cursorline = true

-- Timeout for CursorHold and swap files
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 250

-- Disable mouse
vim.o.mouse = ''

-- No scrolling offset
vim.o.scrolloff = 0

-- Highlight search results
vim.o.hlsearch = true

-- Clear on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Preview substitutions live
vim.o.incsearch = true

-- Case insensitive search
vim.o.ignorecase = true

-- Unless capital in search
vim.o.smartcase = true

-- Enable OS clipboard
vim.o.clipboard = 'unnamedplus'

-- Persist the undo history
vim.o.undofile = true

-- Open vertical splits to the right side of the screen
vim.o.splitright = true

-- Open horizontal splits to the bottom of the screen
vim.o.splitbelow = true

-- Options for builtin completion
vim.o.completeopt = 'menu,menuone,noinsert'

-- Command line completion TODO: review
vim.o.wildmode = 'list:longest'

-- Disable sign column chars for empty lines
vim.o.fillchars = 'eob: '

-- Use a signcolumn with 1 space for git status
vim.o.signcolumn = 'yes:1'

-- Show line numbers
vim.o.number = true

-- Enable folds
vim.o.foldenable = true

-- Required by nvim-ufo
vim.o.foldlevel = 99

-- Required by nvim-ufo
vim.o.foldlevelstart = 99

-- Reduce messages
vim.opt.shortmess = vim.opt.shortmess
  + {
    F = true,
    W = true,
    I = true,
    s = true,
    q = true,
    A = true,
    l = true,
    m = true,
    r = true,
    w = true,
    a = true,
    o = true,
    O = true,
    t = true,
    T = true,
    c = true,
    C = true,
    S = true,
  }

-- Do not show neovim mode
vim.opt.showmode = false

-- Hide commandline
vim.opt.cmdheight = 0

-- Configure diagnostics virtual text and borders
vim.diagnostic.config({
  signs = false,
  virtual_text = {
    prefix = '◦',
    spacing = 0,
  },
  float = {
    border = 'rounded',
  },
})

-- Disable default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Move between windows with <C-hjkl>
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- vim: ts=2 sts=2 sw=2 et
