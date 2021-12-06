" load sources
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/coc/code-completion.vim
source $HOME/.config/nvim/coc/extention-list.vim
source $HOME/.config/nvim/style.vim

" custom keymaps
map <C-o> :NERDTreeToggle<CR> " ctrl + o = toggle nerd tree
inoremap jk <Esc> " jk = enter normal mode

set number relativenumber " dynamic line numbering

set clipboard+=unnamedplus " copy to system clipboard

" add normal mouse scroll
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
