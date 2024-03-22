local M = { 'smartinellimarco/nvcheatsheet.nvim' }

M.opts = {
  keymaps = {
    ['LSP'] = {
      { 'Go to definition', 'gd' },
      { 'Go to declaration', 'gD' },
      { 'Go to implementation', 'gi' },
      { 'Go to type definition', 'go' },
      { 'Go to reference', 'gR' },
      { 'Show signature help', 'gs' },
      { 'Rename element', 'gr' },
      { 'Show available code actions', 'ga' },
      { 'Open diagnostic', 'gl' },
      { 'Hover', 'K' },
      { 'Go to back in definition tag stack', '⌃t' },
      { 'Next diagnostic', ']d' },
      { 'Previous diagnostic', '[d' },
      { 'Show information about attached LSPs', 'LspInfo' },
      { 'Show LSPs logs', 'LspLog' },
      { 'Restart attached LSPs', 'LspRestart' },
      { 'Signature help', '⌃s' },
    },
    ['Telescope'] = {
      { 'Open find files picker', '<leader>e' },
      { 'Open fuzzy finder picker', '<leader>f' },
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
      { 'Toggle oil (closes without saving)', '<leader>o' },
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
      { 'Run formatter/s with LSP as fallback', 'gq' },
    },
    -- TODO: complete
    -- ['Ufo'] = {},
    ['Treesitter'] = {
      { 'Indent code', '=' },
    },
    -- TODO: complete
    -- ['Surround'] = {},
    ['Lazy'] = {
      { 'Open plugin manager', 'Lazy' },
    },
    ['Mason'] = {
      { 'Open LSPs manager', 'Mason' },
    },
    ['Zsh'] = {
      { 'Clear screen', '⌃l' },
      { 'Select previous command', '⌃p' },
      { 'Select next command', '⌃n' },
      { 'Move to the start of the line', '⌃a' },
      { 'Move to the end of the line', '⌃e' },
      { 'Skip word forward', '⌃f' },
      { 'Skip word backward', '⌃b' },
      { 'Delete word', '⌃w' },
      { 'Cut to the end of the line', '⌃k' },
      { 'Cut the whole line', '⌃u' },
      { 'Paste the cut text', '⌃y' },
      { 'Search history', '⌃r' },
      { 'Interrupt the current process', '⌃c' },
      { "Exit current shell. Equivalent to typing 'exit'", '⌃d' },
      { 'Change directory to the most probable match of <dir>', 'z <dir>' },
      { "Accept autosuggestion (equivalent of pressing '→')", '⌃f' },
    },
    ['Kitty'] = {
      { 'Open new tab', '⌘t - ⌃⇧t' },
      { 'Go to tab N', '⌘N - ⌃N' },
      { 'Next tab', '⌃⇥' },
      { 'Previous tab', '⌃⇧⇥' },
      { 'Close tab', '⌘w - ⌃⇧w' },
      { 'Quit application', '⌘q - ⌃⇧q' },
      { 'Copy to clipboard', '⌘c - ⌃⇧c' },
      { 'Paste from clipboard', '⌘v - ⌃⇧v' },
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
