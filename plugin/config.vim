" ============================================================================
" File:        config.vim
" Description: Some vim config I used most frequently which you can remove
"              them all if you find it doesn't make sense to you
" Maintainer:  Jiacheng Feng <fmarsf at gmail dot com>
" Website:     https://github.com/fmars/reasier
" License:     This program is free software. It comes without any warranty,
"              to the extent permitted by applicable law. You can redistribute
"              it and/or modify it under the terms of the Do What The Fuck You
"              Want To Public License, Version 2, as published by Sam Hocevar.
"              See http://sam.zoy.org/wtfpl/COPYING for more details.
" ============================================================================
let mapleader = "-"

inoremap kj <Esc>
vnoremap kj <Esc>
inoremap <Esc> <Nop>
vnoremap <Esc> <Nop>

nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>q :q!<cr>
nnoremap <leader>w :wq<cr>

nnoremap <leader>p :set paste!<Cr>
