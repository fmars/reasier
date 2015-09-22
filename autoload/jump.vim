let g:currentWord=''
function! jump#JumpForward()
    let g:currentWord = escape(expand('<cword>'), '\')
    echo g:currentWord
    execute 'tag '.g:currentWord
    call jump#GetTagStack()
    call jump#DisplayTagStack()
endfunction


let g:tag_stack=''
function! jump#GetTagStack()
    execute 'redir => g:tag_stack'
    execute 'silent tags'
    redir END
endfunction

function! jump#DisplayTagStack()
    set splitbelow
    let s:list=split(g:tag_stack,'\n')
    let s:len=len(s:list)
    echo 's:len'.s:len
    let s:cmd=s:len.'split abc'
    echo s:cmd
    execute s:cmd
    execute "normal Gi".g:tag_stack."\<Esc>"
    execute "normal \<c-w>\<c-w>"
endfunction

function! jump#Jump()
    execute "normal \<c-]>"
    call jump#GetTagStack()
    call jump#DisplayTagStack()
endfunction


let s:dep=0

function! jump#FuncResize()
    let s:f=5
    execute "normal :resize 5\<CR>"
    echo "normal :resize ".s:dep."\<CR>"
endfunction

function! jump#FuncPush()
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

function! jump#FuncPop()
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
