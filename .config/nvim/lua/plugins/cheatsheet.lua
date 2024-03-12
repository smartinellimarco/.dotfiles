local M = { 'smartinellimarco/nvcheatsheet.nvim' }

M.dev = true
M.opts = {
  keymaps = {
    ['LSP'] = {
      { 'Go to definition', 'gd' },
      { 'Go to back in definition tag stack', '⌃t' },
      { 'Go to declaration', 'gD' },
      { 'Go to implementation', 'gi' },
      { 'Go to type definition', 'go' },
      { 'Go to reference', 'gr' },
      { 'Open diagnostics picker', 'gl' },
      { 'Signature help', 'gs' },
      { 'Hover', 'K' },
      { 'Next diagnostic', ']d' },
      { 'Previous diagnostic', '[d' },
      { 'Rename element', '<leader>r' },
      { 'Open available code actions', '<leader>c' },
      { 'Show information about attached LSPs', 'LspInfo' },
      { 'Show LSPs logs', 'LspLog' },
      { 'Restart attached LSPs', 'LspRestart' },
      { 'Signature help', '⌃s' },
    },
    ['Telescope'] = {
      { 'Open find files picker', '<leader>e' },
      { 'Open fuzzy finder picker', '<leader>f' },
      { 'Open workspace diagnostics picker', '<leader>d' },
      { 'Previous result', '⌃p' },
      { 'Next result', '⌃n' },
      { 'Select entry', '⏎' },
      { 'Open vertical split', '⌃v' },
      { 'Open horizontal split', '⌃x' },
      { 'Scroll up in preview', '⌃u' },
      { 'Scroll down in preview', '⌃d' },
      { 'Select result', '⌃s' },
      { 'Select all results', '⌃a' },
      { 'Send selected results to the quickfix list', '⌃q' },
      { 'Quit telescope', '⎋' },
    },
    ['Oil'] = {
      { 'Toggle oil (closes without saving)', '<leader>q' },
      { 'Select entry', '⏎' },
      { 'Select entry', 'l' },
      { 'Go to parent', 'h' },
      { 'Open vertical split', '⌃v' },
      { 'Open horizontal split', '⌃x' },
      { 'Go to current working directory', '.' },
    },
    ['Cmp'] = {
      { 'Select entry', '⌃f' },
      { 'Next result - Jump to next snippet placeholder', '⌃n' },
      { 'Previous result - Jump to previous snippet placeholder', '⌃p' },
      { 'Scroll up in preview', '⌃u' },
      { 'Scroll down in preview', '⌃d' },
      { 'Abort autocompletion', '⌃e' },
    },
    ['Comment'] = {
      { 'Comment line toggle', 'gcc' },
      { 'Comment block toggle', 'gbc' },
      { 'Comment visual selection', 'gc' },
      { 'Comment visual selection using block delimiters', 'gb' },
      { 'Comment out text object line wise', 'gc<motion>' },
      { 'Comment out text object block wise', 'gb<motion>' },
      { 'Add comment on the line above', 'gcO' },
      { 'Add comment on the line below', 'gco' },
      { 'Add comment at the end of line', 'gcA' },
    },
    ['Conform'] = {
      { 'Format code with tools with LSP as a fallback option', '<leader>i' },
    },
    ['Lazy'] = {
      { 'Open plugin manager', 'Lazy' },
    },
    ['Mason'] = {
      { 'Open LSPs manager', 'Mason' },
    },
  },
}

function M.config(_, opts)
  local nvcheatsheet = require('nvcheatsheet')

  nvcheatsheet.setup(opts)

  vim.keymap.set('n', '<F1>', nvcheatsheet.toggle)
end

return M

-- vim: ts=2 sts=2 sw=2 et
