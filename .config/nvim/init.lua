-- If neovim is started from the '/home' or '~/.config' directories
-- assume that GIT_DIR points to the yadm repository
-- NOTE: This is done so lualine shows the branch of the yadm repository
-- and gitsigns shows the changes
if vim.env.GIT_DIR == nil then
  local cwd = vim.fn.getcwd()
  local homedir = vim.fn.expand('~')
  local configdir = vim.fn.expand('~/.config')

  if cwd == homedir or string.sub(cwd, 1, #configdir) == configdir then
    vim.env.GIT_DIR = vim.fn.systemlist('yadm introspect repo')[1]
  end
end

require('lua.settings')
require('lua.lazy')

-- vim: ts=2 sts=2 sw=2 et
