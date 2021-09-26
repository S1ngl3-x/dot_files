" load sources
source $HOME/.config/nvim/vim-plug/plugins.vim
source $HOME/.config/nvim/coc/code-completion.vim

" custom keymaps
map <C-o> :NERDTreeToggle<CR> " ctrl + o = toggle nerd tree
inoremap jk <Esc> " jk = enter normal mode
set number relativenumber

" style neovim
colorscheme onedark
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ }

" add normal mouse scroll
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>