let mapleader = "-"

inoremap kj <Esc>
vnoremap kj <Esc>
inoremap <Esc> <Nop>
vnoremap <Esc> <Nop>

nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>q :q!<cr>
nnoremap <leader>w :wq<cr>

nnoremap <silent> <expr> <leader>f search#SingleHighLightToggle()

nnoremap <leader>a :call jump#FuncPush()<cr>
nnoremap <leader>s :call jump#FuncPop()<cr>
nnoremap <leader>r :call jump#FuncResize()<cr>


nnoremap <leader>g :call jump#GetTagStack()<cr>
nnoremap <leader>d :call jump#DisplayTagStack()<cr>
nnoremap <leader>j :call jump#Jump()<cr>

nnoremap <c-]> :call jump#JumpForward()<cr>
