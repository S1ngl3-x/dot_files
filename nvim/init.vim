source $HOME/.config/nvim/vim-plug/plugins.vim

map <C-o> :NERDTreeToggle<CR>
inoremap jk <Esc>
let mapleader = "'"

set number
set clipboard+=unnamedplus
set ignorecase


syntax on
set noswapfile
set hlsearch
set incsearch

set spell spelllang=en_us

set encoding=utf-8
let python_highlight_all=1

set number relativenumber
colorscheme onedark
call deoplete#custom#option('num_processes', 4)
