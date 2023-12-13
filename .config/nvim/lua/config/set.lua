-- TODO: see https://github.com/neovim/neovim/pull/24723
-- Choose leader
vim.g.mapleader = ' '

-- Configs
vim.o.updatetime = 500                        -- Timeout for CursorHold and swap files
vim.o.mouse = ''                              -- Disable mouse
vim.o.scrolloff = 0                           -- No scrolling offset
vim.wo.number = true                          -- Show line numbers
vim.o.termguicolors = true                    -- Enable truecolor
vim.o.hlsearch = false                        -- Highlight search results
vim.o.incsearch = true                        -- Search incrementally
vim.o.ignorecase = true                       -- Case insensitive search
vim.o.smartcase = true                        -- Unless capital in search
vim.o.wildmode = 'list:longest'               -- TODO: review
vim.o.clipboard = 'unnamedplus'               -- Enable OS clipboard
vim.o.wrap = false                            -- Do not wrap lines
vim.o.undofile = true                         -- Persist the undo history
vim.o.signcolumn = 'yes:1'                    -- Use a signcolumn with 1 space for git status
vim.o.splitright = true                       -- Open vertical splits to the right side of the screen
vim.o.splitbelow = true                       -- Open horizontal splits to the bottom of the screen
vim.opt.showmode = false                      -- Do not show neovim mode
vim.opt.complete = ''                         -- Disable builtin i_CTRL-N and i_CTRL-P in favor of nvim-cmp
vim.opt.completeopt = 'menu,menuone,noselect' -- Options for builtin completion
vim.opt.shortmess = vim.opt.shortmess + {     -- Reduce messages
  -- TODO: find a way to supress these
  F = true,
  W = true,
  I = true,
  s = true,
  q = true,
  A = true,
}

-- vim: ts=2 sts=2 sw=2 et
