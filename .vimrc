filetype plugin on
syntax on
set t_Co=256
set mouse=a
set number
set incsearch
set ignorecase
set smartcase
set smartindent
set expandtab
set autoindent
set tabstop=4
set shiftwidth=2
set softtabstop=2
set linebreak
set t_Co=256
map <leader>tn :tabnew<cr>
map <leader>t<leader> :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

" let g:airline_theme='term'
" let g:ycm_global_ycm_extra_conf = '~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf = "~/.vim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'

let g:vim_ai_token_file_path = '~/.config/openai.token'

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes
Plug 'vim-airline/vim-airline.git'
Plug 'vim-airline/vim-airline-themes.git'
Plug 'editorconfig/editorconfig-vim.git'
Plug 'elkowar/yuck.vim.git'
Plug 'ycm-core/YouCompleteMe.git'
Plug 'ellisonleao/gruvbox.nvim'

" Initialize plugin system
call plug#end()
