-- Set runtime paths
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set Python 3 host program
vim.g.python3_host_prog = '/usr/bin/python3'

-- Filetype and syntax settings
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

-- Treat .ino files as cpp files
vim.cmd('au BufRead,BufNewFile *.ino set filetype=cpp')

-- General settings
vim.opt.termguicolors = true
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.linebreak = true

-- Key mappings
vim.api.nvim_set_keymap('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t<leader>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tm', ':tabmove<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>to', ':tabonly<CR>', { noremap = true, silent = true })


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  { 'elkowar/yuck.vim' },
  { 'neoclide/coc.nvim' },
  { 'tpope/vim-fugitive' },
  { 'nvim-lualine/lualine.nvim' },
  { 'lervag/vimtex' },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    ft = { 'markdown' },  -- ładuj dopiero przy otwarciu pliku .md
    opts = {},
  },
  { 'rose-pine/neovim' },
  { 'sphamba/smear-cursor.nvim' },
  {
    "kiyoon/jupynium.nvim",
    -- build = "pip3 install --user .",
    build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
  },
  "rcarriga/nvim-notify",   -- optional
  "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
})


-- Set background and colorscheme
vim.opt.background = 'dark' -- or 'light' for light mode
vim.cmd('colorscheme rose-pine')

-- Insert mode mappings for coc.nvim
-- Navigate the completion menu
-- coc.nvim Tab completion configuration
-- Tab to confirm completion, Enter for new lines

-- Use Tab for trigger completion and navigate to next complete item
vim.api.nvim_set_keymap('i', '<Tab>', 
  'coc#pum#visible() ? coc#pum#confirm() : "\\<Tab>"',
  { expr = true, silent = true, noremap = true }
)

-- Use Shift-Tab to navigate to previous complete item
vim.api.nvim_set_keymap('i', '<S-Tab>',
  'coc#pum#visible() ? coc#pum#prev() : "\\<C-h>"',
  { expr = true, silent = true, noremap = true }
)

-- Make Enter behave normally (insert new line)
-- This ensures Enter doesn't confirm completion
vim.api.nvim_set_keymap('i', '<CR>', 
  '<CR>',
  { silent = true, noremap = true }
)


require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'rose-pine',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require("smear_cursor").toggle()
return {
  "sphamba/smear-cursor.nvim",

    "benomahony/uv.nvim",
  -- Optional filetype to lazy load when you open a python file
  -- ft = { python }
  -- Optional dependency, but recommended:
     dependencies = {
       "folke/snacks.nvim"
  -- or
  --   "nvim-telescope/telescope.nvim"
     },

  opts = {
    picker_integration = true,

    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears will blend better on all backgrounds.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
  },
}
