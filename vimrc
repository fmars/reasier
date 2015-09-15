let g:fb_kill_whitespace = 0
source $ADMIN_SCRIPTS/master.vimrc
"setlocal foldmethod=syntax
" Note, perl automatically sets foldmethod in the syntax file
autocmd Syntax c,cpp,vim,xml,html,xhtml setlocal foldmethod=syntax
autocmd Syntax c,cpp,vim,xml,html,xhtml,perl normal zR
set hlsearch

:color fjc

set number
map <space> viw
inoremap <c-u> <esc>viwUwa
let mapleader = "-"
nnoremap <leader>d dd
noremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader> bi"<esc>ea"<esc>

inoremap kj <esc>
inoremap <esc> <nop>
vnoremap kj <esc>
vnoremap <esc> <nop>



" Highlight all instances of word under cursor, when idle.
" " Useful when studying strange source code.
" " Type z/ to toggle highlighting on/off.
nnoremap hla :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
      setl updatetime=4000
      echo 'Highlight current word: off'
      return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

nnoremap hl :call SingleHighLightToggle()<CR>
function! SingleHighLightToggle()
  if @/ == ''
    let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
  else
    let @/ = ''
  endif
endfunction

nmap <F8> :TagbarToggle<CR>
execute pathogen#infect()
map <F9> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
