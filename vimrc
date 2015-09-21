

inoremap kj <Esc>
vnoremap kj <Esc>
imap <F2> GoDate: <Esc>:read !date<CR>kJ
cmap kj <Esc> 

nnoremap <leader>h :call SingleHighLightToggle()<CR>
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


let mapleader = "-"
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>a :call FuncPush()<cr>
nnoremap <leader>s :call FuncPop()<cr>
nnoremap <leader>r :call FuncResize()<cr>
nnoremap <leader>q :q!<cr>

let s:dep=0

function! FuncResize()
    let s:f=5
    execute "normal :resize 5\<CR>"
    echo "normal :resize ".s:dep."\<CR>"
endfunction

function! FuncPush()
    let s:str=getline(".")
    if s:dep==0
        set splitbelow
        execute '1split traceback'
        execute "normal Gi".s:str."\<Esc>"
        execute "normal \<c-w>\<c-w>"
    else
        execute "normal \<c-w>\<c-w>"
        let s:size=s:dep+1
        execute "normal :resize ".s:size."\<cr>"
        execute "normal Go".s:str."\<Esc>"
        execute "normal \<Esc>"
        execute "normal \<c-w>\<c-w>"
    endif
    let s:dep+=1
endfunction

function! FuncPop()
    let s:dep-=1
    if s:dep==0
        execute "normal \<c-w>\<c-w>"
        execute "normal :q!\<CR>"
    elseif s:dep >0
        execute "normal \<c-w>\<c-w>"
        let s:size=s:dep+1
        execute "normal :resize ".s:size."\<cr>"
        execute "normal Gdd"
        execute "normal \<Esc>"
        execute "normal \<c-w>\<c-w>"
    endif
    
endfunction

function! TestFunc()
    echom 'func1'
    echom 'func2'
    echom 'func3'
    normal <cr>
endfunction
command! FJC :call TestFunc()

nmap <F8> :TagbarToggle<CR>
