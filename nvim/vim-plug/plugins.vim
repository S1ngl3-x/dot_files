" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'joshdick/onedark.vim', {'branch': 'main'}    
    Plug 'vim-airline/vim-airline'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}    
    Plug 'preservim/nerdtree'
    Plug 'dag/vim-fish'
    Plug 'fladson/vim-kitty', {'branch': 'main'}    

call plug#end()
