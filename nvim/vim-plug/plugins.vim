" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'
    " File Explorer
    Plug 'scrooloose/NERDTree'
    " Auto pairs for '(' '[' '{' 
    Plug 'jiangmiao/auto-pairs'

    Plug 'https://github.com/itchyny/lightline.vim'
    Plug 'https://github.com/wikitopian/hardmode'
    Plug 'https://github.com/tpope/vim-surround'
    Plug 'https://github.com/airblade/vim-gitgutter'
    Plug 'https://github.com/joshdick/onedark.vim'
    Plug 'https://github.com/xolox/vim-misc'
    Plug 'https://github.com/xolox/vim-lua-ftplugin'
    Plug 'https://github.com/elzr/vim-json'
call plug#end()
