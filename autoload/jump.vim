let g:tag_stack_visibility = 1
let s:debug_file = ''
let s:debug_toggle = 1
function! s:StartDebug(filename) abort
    if empty(a:filename)
        let s:debug_file = 'reasier.log'
    else
        let s:debug_file = a:filename
    endif
endfunction
call s:StartDebug('')

function! s:debug(msg)
    if s:debug_toggle
        execute 'redir >> ' . s:debug_file
        silent echon a:msg . "\n"
        redir END
    endif
endfunction

function! s:goto_win(winnr, ...) abort
    let cmd = type(a:winnr) == type(0) ? a:winnr . 'wincmd w'
                \ : 'wincmd ' . a:winnr
    let noauto = a:0 > 0 ? a:1 : 0

    call s:debug("goto_win(): " . cmd . ", " . noauto)

    if noauto
        noautocmd execute cmd
    else
        execute cmd
    endif
endfunction

let g:currentWord=''
let s:tag_stack_size_display = 1
function! jump#JumpForward()
    call s:debug('JumpForward called')

    let currentWord = escape(expand('<cword>'), '\')
    call s:debug('Current word is '.currentWord)
    execute 'tag '.currentWord
    let s:tag_stack_size_display += 2
    call s:GetTagStack()
    call s:DisplayTagStack()
endfunction

function! jump#JumpBackward()
    call s:debug('JumpBackward called')

    execute 'pop'
    let s:tag_stack_size_display -= 1
    call s:GetTagStack()
    call s:DisplayTagStack()
endfunction

" ----------------------------------
" GetTagStack()
function! jump#GetTagStack()
    call s:GetTagStack()
endfunction

let s:tag_stack = []
let s:tag_stack_display = []
function! s:GetTagStack()
    call s:debug('GetTagStack called')

    execute 'redir => tag_stack_str'
    execute 'silent tags'
    redir END
    let s:tag_stack = split(tag_stack_str, '\n')
    call s:debug('Current TagStack len is '.len(s:tag_stack))
endfunction

" ----------------------------------
" DisplayTagStack()
function! jump#DisplayTagStack()
    call s:DisplayTagStack()
endfunction

function! s:DisplayTagStack()
    call s:debug('DisplayTagStack called')

    let tag_stack_display = []
    let i = 0
    while i < s:tag_stack_size_display
        call add(tag_stack_display, s:tag_stack[i])
        let i += 1
    endwhile

    if s:tag_stack_size_display  > 2
        let tag_stack_winnr = bufwinnr('__call_stack__')
        if tag_stack_winnr == -1
            let cmd_split_window = 'silent keepalt ' . (s:tag_stack_size_display + 1). 'split' . '__call_stack__'
            set splitbelow
            execute cmd_split_window
            for tag_entry in tag_stack_display
                execute "normal Gi".tag_entry."\<Cr>\<Esc>"
            endfor
            execute "normal \<c-w>\<c-w>"
        else
            call s:goto_win(tag_stack_winnr)
            execute "q!"
            call s:DisplayTagStack()
        endif
    else
        let tag_stack_winnr = bufwinnr('__call_stack__')
        call s:goto_win(tag_stack_winnr)
        execute "q!"
    endif 

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
