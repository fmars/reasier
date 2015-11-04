" File:        tagbar.vim
" Description: Tagbar syntax settings
" Author:      Jan Larres <jan@majutsushi.net>
" Licence:     Vim licence
" Website:     http://majutsushi.github.com/tagbar/
" Version:     2.6.1

scriptencoding utf-8

if exists("b:current_syntax")
    finish
endif

syntax keyword reasierKeyword TO FROM
highlight link reasierKeyword Keyword

syntax match reasierHelp      '^".*' 
highlight default link reasierHelp Comment

syntax match reasierPtr "^>.*"
highlight default reasierPtr guifg=Red ctermfg=Red

let b:current_syntax = "reasier"

" vim: ts=8 sw=4 sts=4 et foldenable foldmethod=marker foldcolumn=1
