let mapleader = "-"

inoremap kj <Esc>
vnoremap kj <Esc>
inoremap <Esc> <Nop>
vnoremap <Esc> <Nop>

nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>q :q!<cr>
nnoremap <leader>w :wq<cr>

nnoremap <silent> <expr> <leader>f search#SingleHighLightToggle()

nnoremap <leader>a :call FuncPush()<cr>
nnoremap <leader>s :call FuncPop()<cr>
nnoremap <leader>r :call FuncResize()<cr>
