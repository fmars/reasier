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
" autocmd WinLeave * :call jump#AutoClose()<Cr>

