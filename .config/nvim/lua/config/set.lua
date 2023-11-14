-- Choose leader
vim.g.mapleader = ' '

-- Configs
vim.opt.shortmess = vim.opt.shortmess + {
  F = true,
  W = true,
  I = true,
  s = true,
  q = true,
  A = true,
}
vim.o.signcolumn = 'yes'
vim.o.mouse = ''
vim.o.scrolloff = 0
vim.wo.number = true
vim.o.termguicolors = true
vim.opt.fillchars = { eob = ' ' }
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.wildmode = 'list:longest'
vim.o.completeopt = 'menuone,noselect'
vim.o.clipboard = 'unnamedplus'
vim.o.wrap = false
vim.o.undofile = true
vim.o.signcolumn = 'yes:2'
vim.o.splitright = true

-- Clear jumplist when vim starts
vim.api.nvim_command("autocmd VimEnter * exe 'clearjumps'")

-- Launch telescope file picker and change dir when opening neovim
-- with a directory argument
vim.api.nvim_command("autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'Telescope find_files' | execute 'cd '.argv()[0] | endif")

-- Open help window in a vertical split to the right.
vim.api.nvim_command("autocmd BufEnter * if &filetype=='help' | wincmd L | endif")

-- vim: ts=2 sts=2 sw=2 et
