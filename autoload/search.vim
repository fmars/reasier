let s:lastSearchWord=''
function! SingleHighLightToggle()
    let b:currentWord = '\V\<'.escape(expand('<cword>'), '\').'\>'
    if @/ == '' || s:lastSearchWord == '' || @/ != s:lastSearchWord || s:lastSearchWord != b:currentWord
        let @/ = b:currentWord
        let s:lastSearchWord=@/
    else
        let @/ = ''
        let s:lastSearchWord = ''
    endif
endfunction
