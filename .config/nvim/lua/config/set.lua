-- TODO: configure tabs
-- Choose leader
vim.g.mapleader = ' '

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

-- Do not highlight search results
vim.o.hlsearch = false

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

-- Command line completion
vim.o.wildmode = 'list:longest'

-- Disable sign column chars for empty lines
vim.o.fillchars = 'eob: '

-- Use a signcolumn with 1 space for git status
vim.o.signcolumn = 'yes:1'

-- Show line numbers
vim.o.number = true

-- Sync buffers automatically
vim.o.autoread = true

-- Disable neovim generating a swapfile and showing the error
vim.o.swapfile = false

-- Reduce messages by setting various 'shortmess' flags
vim.opt.shortmess = vim.opt.shortmess
  + {
    F = true, -- Don't give the file info when editing a file
    W = true, -- Don't give "written" or "[w]" when writing a file
    I = true, -- Don't give the intro message when starting Vim
    s = true, -- Don't give "search hit BOTTOM/TOP" messages
    q = true, -- Don't show "recording @a" when recording a macro
    A = true, -- Don't give the "ATTENTION" message when an existing swap file is found
    a = true, -- Use all abbreviations (l, m, r, w)
    o = true, -- Overwrite message for writing a file with subsequent message for reading a file
    O = true, -- Message for reading a file overwrites any previous message
    t = true, -- Truncate file message at the start if it is too long to fit
    T = true, -- Truncate other messages in the middle if they are too long to fit
    c = true, -- Don't give ins-completion-menu messages
    C = true, -- Don't give messages while scanning for ins-completion items
    S = true, -- Don't show search count message when searching
  }

-- Do not show neovim mode
vim.opt.showmode = false

-- Do not show tabline
vim.opt.showtabline = 0

-- Switch to the next tab
vim.keymap.set('n', '<Tab>', function()
  vim.cmd('tabnext')
end)

-- Switch to the previous tab
vim.keymap.set('n', '<S-Tab>', function()
  vim.cmd('tabprevious')
end)

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

-- Disable providers since all our plugins are made with lua
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- vim: ts=2 sts=2 sw=2 et
