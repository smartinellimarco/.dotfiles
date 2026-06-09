-- If nvim is started from '$HOME' or '$HOME/.config', point GIT_DIR at the
-- yadm repo so lualine shows the dotfiles branch and gitsigns picks up changes
if vim.env.GIT_DIR == nil then
  local cwd = vim.fn.getcwd()
  local homedir = vim.fn.expand('~')
  local configdir = vim.fn.expand('~/.config')
  if cwd == homedir or string.sub(cwd, 1, #configdir) == configdir then
    vim.env.GIT_DIR = vim.fn.systemlist('yadm introspect repo')[1]
  end
end

vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.winborder = 'rounded'
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.confirm = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.fillchars = 'eob: '
vim.o.signcolumn = 'yes:1'
vim.o.number = true
vim.o.showtabline = 0

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- See :h 'shortmess' for flag meanings
vim.opt.shortmess:append('WIsqAacS')

-- TODO: still needed?
vim.diagnostic.config({
  signs = false,
  virtual_text = { prefix = '◦', spacing = 0 },
  float = { border = 'rounded' },
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd('clearjumps')
  end,
})

-- ============================================================
-- PLUGINS (vim.pack)
-- ============================================================

local gh = function(repo)
  return 'https://github.com/' .. repo
end

-- Build hooks fire on install/update via PackChanged. Register before add().
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if
      name == 'telescope-fzf-native.nvim'
      and (kind == 'install' or kind == 'update')
    then
      vim.system({ 'make' }, { cwd = ev.data.path }):wait()
    end
  end,
})

vim.pack.add({
  -- Colorscheme
  gh('gbprod/nord.nvim'),

  -- UI
  gh('nvim-lualine/lualine.nvim'),
  gh('yavorski/lualine-macro-recording.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('lukas-reineke/indent-blankline.nvim'),

  -- Editing
  { src = 'https://codeberg.org/andyg/leap.nvim' },
  gh('shushtain/incselect.nvim'),
  gh('windwp/nvim-autopairs'),
  gh('kylechui/nvim-surround'),
  gh('folke/ts-comments.nvim'),
  gh('NMAC427/guess-indent.nvim'),

  -- File manager
  gh('stevearc/oil.nvim'),

  -- Telescope
  gh('nvim-lua/plenary.nvim'),
  gh('nvim-telescope/telescope.nvim'),
  gh('nvim-telescope/telescope-fzf-native.nvim'),

  -- Treesitter
  gh('romus204/tree-sitter-manager.nvim'),
  {
    src = gh('nvim-treesitter/nvim-treesitter-textobjects'),
    version = 'main',
  },

  -- Completion
  gh('rafamadriz/friendly-snippets'),
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1') },

  -- Formatter
  gh('stevearc/conform.nvim'),

  -- LSP
  gh('neovim/nvim-lspconfig'),
  gh('folke/lazydev.nvim'),
  gh('RRethy/vim-illuminate'),
})

-- ============================================================
-- COLORSCHEME
-- ============================================================

require('nord').setup({
  borders = true,
  styles = {
    comments = { italic = true },
  },
})
vim.cmd.colorscheme('nord')

-- ============================================================
-- PLUGIN SETUP
-- ============================================================

require('nvim-autopairs').setup({
  check_ts = true,
  enable_check_bracket_line = true,
  map_c_w = true,
  map_c_h = true,
})

require('nvim-surround').setup({})

require('ts-comments').setup()

require('guess-indent').setup({ override_editorconfig = false })

require('ibl').setup({
  indent = { char = '┊' },
  scope = { enabled = false },
})

do
  local gs = require('gitsigns')
  gs.setup({
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 500,
      ignore_whitespace = false,
      virt_text_priority = 5000, -- LSP diagnostics priority is 4096 (0x1000)
    },
    current_line_blame_formatter = '◦ <author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_formatter_nc = '◦ Not committed yet',
  })
  -- gs.nav_hunk is async, which breaks operator-pending motions
  -- (the callback returns before the cursor moves, so vim sees no motion).
  -- We resolve the target hunk synchronously from gs.get_hunks() and jump.
  local function jump_to(h)
    local n = vim.api.nvim_buf_line_count(0)
    local line = math.max(1, math.min(h.added.start, n))
    vim.api.nvim_win_set_cursor(0, { line, 0 })
  end

  local function nav(dir)
    return function()
      local hunks = gs.get_hunks(0) or {}
      if #hunks == 0 then
        return
      end
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local target
      if dir == 'next' then
        for _, h in ipairs(hunks) do
          if h.added.start > row then
            target = h
            break
          end
        end
        target = target or hunks[1]
      else
        for i = #hunks, 1, -1 do
          if hunks[i].added.start < row then
            target = hunks[i]
            break
          end
        end
        target = target or hunks[#hunks]
      end
      jump_to(target)
    end
  end

  vim.keymap.set({ 'n', 'x', 'o' }, ']h', nav('next'))
  vim.keymap.set({ 'n', 'x', 'o' }, '[h', nav('prev'))

  -- ih: text object — containing hunk, else next, else wrap. Selects iff
  -- the hunk has buffer content (added.count > 0); pure-delete hunks just
  -- get a cursor jump, because select_hunk would emit a wonky range for
  -- them (e.g. `0G` when added.start is 0 for a top-of-file delete).
  vim.keymap.set({ 'o', 'x' }, 'ih', function()
    local hunks = gs.get_hunks(0) or {}
    if #hunks == 0 then
      return
    end
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local function contains(h)
      return h.added.count > 0
        and row >= h.added.start
        and row <= h.added.start + h.added.count - 1
    end
    local target
    for _, h in ipairs(hunks) do
      if contains(h) then
        target = h
        break
      end
    end
    if not target then
      for _, h in ipairs(hunks) do
        if h.added.start > row then
          target = h
          break
        end
      end
      target = target or hunks[1]
    end
    jump_to(target)
    if target.added.count > 0 then
      gs.select_hunk()
    end
  end)
end

require('lualine').setup({
  options = {
    theme = 'nord',
    globalstatus = true,
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'filename',
        path = 1,
        fmt = function(name)
          return vim.bo.filetype == 'TelescopePrompt' and 'telescope' or name
        end,
      },
    },
    lualine_c = { 'branch', 'diagnostics' },
    lualine_x = { 'macro_recording', 'encoding' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

do
  local oil = require('oil')
  oil.setup({
    view_options = { show_hidden = true },
    columns = {},
    keymaps = {
      ['<CR>'] = 'actions.select',
      ['-'] = 'actions.parent',
      ['_'] = 'actions.open_cwd',
      ['`'] = 'actions.cd',
      ['<C-v>'] = 'actions.select_vsplit',
      ['<C-x>'] = 'actions.select_split',
      ['<C-c>'] = 'actions.close',
      ['<leader>o'] = function() end,
    },
    skip_confirm_for_simple_edits = false,
    ---@diagnostic disable-next-line: assign-type-mismatch
    cleanup_delay_ms = false, -- oil's @field says integer? but false disables cleanup
    prompt_save_on_select_new_entry = true,
    use_default_keymaps = false,
  })
  vim.keymap.set('n', '<leader>o', oil.open)
end

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Incremental selection (treesitter)
do
  local inc = require('incselect')
  vim.keymap.set('n', '<A-o>', inc.init)
  vim.keymap.set('x', '<A-o>', inc.parent)
  vim.keymap.set('x', '<A-i>', inc.undo)
end

-- Telescope
do
  local telescope = require('telescope')
  local builtin = require('telescope.builtin')
  local actions = require('telescope.actions')
  telescope.setup({
    pickers = {
      find_files = { hidden = true },
      live_grep = { additional_args = { '--fixed-strings' } },
    },
    defaults = {
      prompt_prefix = '> ',
      layout_strategy = 'horizontal',
      layout_config = {
        width = 0.99,
        height = 0.99,
        preview_width = 0.55,
      },
      preview = { treesitter = true },
      default_mappings = {
        i = {
          ['<Esc>'] = actions.close,
          ['<C-c>'] = actions.close,
          ['<C-n>'] = actions.move_selection_next,
          ['<C-p>'] = actions.move_selection_previous,
          ['<CR>'] = actions.select_default,
          ['<C-x>'] = actions.select_horizontal,
          ['<C-v>'] = actions.select_vertical,
          ['<C-u>'] = actions.preview_scrolling_up,
          ['<C-d>'] = actions.preview_scrolling_down,
          ['<C-w>'] = { '<C-s-w>', type = 'command' },
        },
      },
    },
  })
  telescope.load_extension('fzf')
  vim.keymap.set('n', '<leader>e', builtin.find_files)
  vim.keymap.set('n', '<leader>f', builtin.live_grep)
  vim.keymap.set('n', '<leader>d', builtin.diagnostics)
  -- Replace default qflist-based LSP pickers
  vim.keymap.set('n', 'grr', builtin.lsp_references)
  vim.keymap.set('n', 'gri', builtin.lsp_implementations)
  vim.keymap.set('n', 'grt', builtin.lsp_type_definitions)
  vim.keymap.set('n', 'gO', builtin.lsp_document_symbols)
end

-- Treesitter (parsers via tree-sitter-manager.nvim)
do
  require('tree-sitter-manager').setup({
    ensure_installed = 'all',
    nerdfont = false,
  })

  require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
    move = { set_jumps = true },
  })

  local select = require('nvim-treesitter-textobjects.select').select_textobject
  local move = require('nvim-treesitter-textobjects.move')
  local captures = {
    f = '@function',
    c = '@class',
    l = '@loop',
    i = '@conditional',
    p = '@parameter',
    s = '@call',
    a = '@assignment',
  }
  for key, capture in pairs(captures) do
    vim.keymap.set({ 'x', 'o' }, 'a' .. key, function()
      select(capture .. '.outer', 'textobjects')
    end)
    vim.keymap.set({ 'x', 'o' }, 'i' .. key, function()
      select(capture .. '.inner', 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, ']' .. key, function()
      move.goto_next_start(capture .. '.outer', 'textobjects')
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, '[' .. key, function()
      move.goto_previous_start(capture .. '.outer', 'textobjects')
    end)
  end
end

-- lazydev — makes lua_ls aware of nvim's Lua API and plugins on rtp
require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

-- illuminate — highlights other occurrences of word under cursor
require('illuminate').configure({
  providers = { 'lsp', 'treesitter', 'regex' },
  delay = 100,
  filetypes_denylist = {
    'oil',
  },
})

-- Blink completion
require('blink.cmp').setup({
  completion = {
    keyword = { range = 'full' }, -- replace whole word, not just prefix
    list = { selection = { auto_insert = false } },
    menu = {
      border = 'rounded',
      draw = {
        align_to = 'cursor',
        columns = {
          { 'label' },
          { 'kind_icon', 'kind', gap = 1 },
          { 'label_description' },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = { border = 'rounded' },
    },
  },
  keymap = {
    preset = 'none',
    ['<C-f>'] = { 'accept' },
    -- chain: menu selection → snippet jump → default keybind
    ['<C-n>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<C-p>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<C-u>'] = { 'scroll_documentation_up' },
    ['<C-d>'] = { 'scroll_documentation_down' },
    ['<C-e>'] = { 'cancel' },
  },
  cmdline = {
    completion = {
      menu = { draw = { columns = { { 'label' } } } },
    },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
})

-- Conform formatter
do
  local conform = require('conform')
  conform.setup({
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
    },
  })
  vim.keymap.set({ 'n', 'x' }, 'gq', function()
    conform.format({ async = true, lsp_format = 'fallback', quiet = true })
  end)
end

-- ============================================================
-- LSP
-- ============================================================

-- Per-server overrides live in ~/.config/nvim/after/lsp/<name>.lua
local servers = {
  'rust_analyzer',
  'bashls',
  'gopls',
  'terraformls',
  'rumdl',
  'docker_language_server',
  'texlab',
  'zls',
  'just',
  'ruff',
  'ty',
  'lua_ls',
  'jsonls',
  'yamlls',
}

vim.lsp.config('*', {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
})
vim.lsp.enable(servers)
