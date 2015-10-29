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
    silent! execute 'tag '.currentWord
    let error_msg = 'E426: tag not found: '.currentWord
    if error_msg != v:errmsg
        let s:tag_stack_size_display += 1
        call s:GetTagStack()
        call s:DisplayTagStack()
    else
        echo v:errmsg
    endif
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

    call s:debug('Construct display tag stack')
    let tag_stack_display = []
    let i = 0

    while i < s:tag_stack_size_display
        call s:debug(printf("%d", i))
        call add(tag_stack_display, s:tag_stack[i])
        let i += 1
    endwhile

    if s:tag_stack_size_display  > 1
        let tag_stack_winnr = bufwinnr('__call_stack__')
        call s:debug('tag_stack_winnr' + tag_stack_winnr)
        if tag_stack_winnr == -1
            let cmd_split_window = 'silent keepalt ' . (s:tag_stack_size_display). 'split' . '__call_stack__'
            set splitbelow
            execute cmd_split_window

            let i = 0
            while i < s:tag_stack_size_display - 1
                execute "normal Gi".tag_stack_display[i]."\<Cr>\<Esc>"
                let i += 1
            endwhile
            let part_str = strpart(tag_stack_display[i], 1)
            let str = '>'.part_str 
            execute "normal Gi".str."\<Esc>"

            setlocal filetype=reasier

            setlocal noreadonly " in case the "view" mode is used
            setlocal buftype=nofile
            setlocal bufhidden=hide
            setlocal noswapfile
            setlocal nobuflisted
            setlocal nomodifiable
            setlocal nolist
            setlocal nowrap
            setlocal winfixwidth
            setlocal textwidth=0
            setlocal nospell

            execute "normal \<c-w>\<c-w>"
        else
            call s:debug('Window already exists. Close it first')
            call s:goto_win(tag_stack_winnr)
            setlocal modifiable
            execute "q!"
            call s:DisplayTagStack()
        endif
    else
        call s:debug('No available display tag remained. Close it')
        let tag_stack_winnr = bufwinnr('__call_stack__')
        call s:goto_win(tag_stack_winnr)
        execute "q!"
    endif 

endfunction
