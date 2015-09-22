let s:lastSearchWord=''
function! search#SingleHighLightToggle()
    let s:currentWord = '\V\<'.escape(expand('<cword>'), '\').'\>'
    if @/ == '' || s:lastSearchWord == '' || @/ != s:lastSearchWord || s:lastSearchWord != s:currentWord
        let @/ = s:currentWord
        let s:lastSearchWord=@/
        execute "set tagstack?"
        return ":silent set hlsearch\<CR>"
    else
        let @/ = ''
        let s:lastSearchWord = ''
    endif
endfunction
