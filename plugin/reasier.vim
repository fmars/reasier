" ============================================================================
" File:        reasier.vim
" Description: Bind most useful functions with <leader> here
" Maintainer:  Jiacheng Feng <fmarsf at gmail dot com>
" Website:     https://github.com/fmars/reasier
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" ============================================================================

" ======================================
" High Light Search
" ======================================
command! -nargs=0 SHLSearch call widget#SingleHighLightToggle()
nnoremap <silent> <expr> <leader>f widget#SingleHighLightToggle()

" ======================================
" Tag Stack
" ======================================  
command! -nargs=0 ReasierDebug call jump#ToggleDebug()

nnoremap <C-]> :call jump#JumpForward()<Cr>
nnoremap <C-t> :call jump#JumpBackward()<Cr>
nnoremap <leader>t :call jump#ToggleTagStack()<Cr>
autocmd WinEnter * :call jump#AutoClose()

