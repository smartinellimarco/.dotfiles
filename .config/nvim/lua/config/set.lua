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
vim.opt.completeopt = 'menu,menuone,noselect' -- Options for builtin completion
vim.opt.laststatus = 0                        -- Hide statusline
vim.opt.cmdheight = 0                         -- Hide commandline (see: https://github.com/neovim/neovim/issues/19193)
vim.opt.shortmess = vim.opt.shortmess + {     -- Reduce messages
  -- TODO: find a way to supress these
  F = true,
  W = true,
  I = true,
  s = true,
  q = true,
  A = true,
}

-- Turn relative numbers on/off depending on the current mode
local augroup = vim.api.nvim_create_augroup("numbertoggle", {})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "CmdlineLeave", "WinEnter" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu and vim.api.nvim_get_mode().mode ~= "i" then
         vim.opt.relativenumber = true
      end
   end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "CmdlineEnter", "WinLeave" }, {
   pattern = "*",
   group = augroup,
   callback = function()
      if vim.o.nu then
         vim.opt.relativenumber = false
         vim.cmd "redraw"
      end
   end,
})

-- vim: ts=2 sts=2 sw=2 et
