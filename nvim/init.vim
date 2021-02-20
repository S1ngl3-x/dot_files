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

colorscheme onedark
