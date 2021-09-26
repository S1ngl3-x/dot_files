" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'https://github.com/joshdick/onedark.vim'
    Plug 'https://github.com/itchyny/lightline.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    
    Plug 'preservim/nerdtree'
let g:deoplete#enable_at_startup = 1
call plug#end()
