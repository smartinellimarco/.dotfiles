-- Clear jumplist when vim starts
vim.api.nvim_command("autocmd VimEnter * exe 'clearjumps'")

-- Launch telescope file picker and change dir when opening neovim
-- with a directory argument
vim.api.nvim_command("autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | execute 'Telescope find_files' | execute 'cd '.argv()[0] | endif")

-- Open help window in a vertical split to the right.
-- TODO: this flickers
vim.api.nvim_command("autocmd BufEnter * if &filetype=='help' | wincmd L | endif")

-- vim: ts=2 sts=2 sw=2 et
