-- Choose leader
vim.g.mapleader = ' '

-- Configs
vim.o.mouse = ''                       -- Disable mouse
vim.o.scrolloff = 0                    -- No scrolling offset
vim.wo.number = true                   -- Show line numbers
vim.o.termguicolors = true             -- Enable truecolor
vim.o.hlsearch = false                 -- Highlight search results
vim.o.incsearch = true                 -- Search incrementally
vim.o.ignorecase = true                -- Case insensitive search
vim.o.smartcase = true                 -- Unless
vim.o.wildmode = 'list:longest'        -- TODO: review
vim.o.completeopt = 'menuone,noselect' -- TODO: review
vim.o.clipboard = 'unnamedplus'        -- Enable OS clipboard
vim.o.wrap = false                     -- Do not wrap lines
vim.o.undofile = true                  -- Persist the undo history
vim.o.signcolumn = 'yes:1'             -- Use a signcolumn with 1 space for git status
vim.o.splitright = true                -- Open vertical splits to the right side of the screen

-- TODO: reduce messages or use noice to capture them
vim.opt.shortmess = vim.opt.shortmess + {
  F = true,
  W = true,
  I = true,
  s = true,
  q = true,
  A = true,
}

-- TODO: review
vim.opt.cmdheight = 0
vim.opt.showmode = false -- Do not show neovim mode

-- Clear jumplist when vim starts
vim.api.nvim_command("autocmd VimEnter * exe 'clearjumps'")

-- Launch telescope file picker and change dir when opening neovim
-- with a directory argument
vim.api.nvim_command("autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'Telescope find_files' | execute 'cd '.argv()[0] | endif")

-- Open help window in a vertical split to the right.
vim.api.nvim_command("autocmd BufEnter * if &filetype=='help' | wincmd L | endif")

-- vim: ts=2 sts=2 sw=2 et
