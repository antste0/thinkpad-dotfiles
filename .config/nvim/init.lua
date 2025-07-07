-- Set runtime paths
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set Python 3 host program
vim.g.python3_host_prog = '/usr/bin/python3'

-- Set background and colorscheme
vim.opt.background = 'dark' -- or 'light' for light mode
vim.cmd('colorscheme gruvbox')

-- Filetype and syntax settings
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

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

-- YouCompleteMe settings
vim.g.ycm_global_ycm_extra_conf = "~/.local/share/nvim/site/pack/packer/start/YouCompleteMe.git/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
vim.g.ycm_server_python_interpreter = '/usr/bin/python3'
vim.g.ycm_rust_server = 'rust-analyzer'
vim.g.ycm_rust_toolchain_root = vim.fn.expand('~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu')
vim.g.ycm_server_keep_logfiles = 1
vim.g.ycm_server_log_level = 'debug'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox-material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
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
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
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

vim.g.ycm_language_server = {
  {
    name = 'rust',
    cmdline = { 'rust-analyzer' },
    filetypes = { 'rust' },
    project_root_files = { 'Cargo.toml' }
  }
}

require('packer').startup(function(use)
    use 'https://github.com/elkowar/yuck.vim.git'
    use 'https://github.com/ycm-core/YouCompleteMe.git'
    --use 'rust-lang/rust.vim'
    use 'https://github.com/tpope/vim-fugitive'
    use 'nvim-lualine/lualine.nvim'
    use 'https://github.com/lervag/vimtex'
    use 'https://github.com/morhetz/gruvbox'
end)

