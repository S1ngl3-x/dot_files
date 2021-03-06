source $HOME/.config/nvim/vim-plug/plugins.vim

let g:HardMode_level = 'wannabe'
let g:HardMode_hardmodeMsg = 'Don''t use this!'
autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()

"map <C-o> :NERDTreeToggle<CR>

set number
colorscheme onedark
set clipboard+=unnamedplus
set ignorecase
hi Normal guibg=NONE ctermbg=NONE
