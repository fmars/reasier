command! -nargs=0 SHLSearch call search#SingleHighLightToggle()
nnoremap <silent> <expr> <leader>f search#SingleHighLightToggle()

nnoremap <leader>g :call jump#GetTagStack()<cr>
nnoremap <leader>d :call jump#DisplayTagStack()<cr>
nnoremap <leader>j :call jump#Jump()<cr>


nnoremap <F7> :ReasierJump<Cr>
command! -nargs=0 Reasier call jump#ToggleWindow()
command! -nargs=0 ReasierJump call jump#JumpForward()

nnoremap <C-]> :call jump#JumpForward()<cr>
nnoremap <C-t> : call jump#JumpBackward()<Cr>
