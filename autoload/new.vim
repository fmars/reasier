" tag stack pointer points to the index of last tag
let s:tag_stack_ptr = -1 
let s:toggle_tag_stack = 1
let s:toggle_tag_stack_help = 0
let s:toggle_debug = 0

let s:tag_stack_win_name = '__call_stack__'
let s:debug_file = 'reaser.log'
" ======================================
" debug
" ======================================
function! s:StartDebug(filename) abort
    if empty(a:filename)
        let s:debug_file = 'reasier.log'
    else
        let s:debug_file = a:filename
    endif
endfunction
call s:StartDebug('')

function! s:debug(msg)
    if s:toggle_debug
        execute 'redir >> ' . s:debug_file
        silent echon a:msg . "\n"
        redir END
    endif
endfunction

" ======================================
" Viewer
" ======================================
function! s:GoToWin(winnr, ...) abort
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

function! s:CloseWin()
    call s:debug('CloseWin() Start')

    let tag_stack_winnr = bufwinnr(s:tag_stack_win_name)
    if tag_stack_winnr == -1
        return
    endif

    if winnr() == tag_stack_winnr
        close
    else
        let cur_winnr = winnr()
        call s:GoToWin(tag_stack_winnr)
        close
        call s:GoToWin(cur_winnr)
    endif

    call s:debug('CloseWin() Done')
endfunction

function! s:Render()
    call s:debug('Render() Start')

    call s:CloseWin()
    let help_content = s:GetHelpContent()
    let tag_stack = s:GetTagStack()

    if s:toggle_tag_stack && s:tag_stack_ptr >= 0
        let cur_winnr = winnr()

        let content = s:GenContent(help_content, tag_stack) 
        let split_win_cmd = 'silent keepalt ' . (len(content)). 'split' . s:tag_stack_win_name
        set splitbelow
        execute split_win_cmd 
        setlocal modifiable

        let i = 0
        while i < len(content) -1
            execute "normal Gi".content[i]."\<Cr>\<Esc>"
            let i += 1
        endwhile
        let part_str = strpart(content[i], 1)
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

        call s:GoToWin(cur_winnr)
    endif

    call s:debug('Render() Done')
endfunction

function! s:GetHelpContent()
    if s:toggle_tag_stack_help == 0
        return ['press ? to get help']
    else
        return ['this is the help you want']
    endif
endfunction

function! s:GetTagStack()
    call s:debug('GetTagStack() Start ')

    execute 'redir => tag_stack_str'
    execute 'silent tags'
    redir END
    let tag_stack = split(tag_stack_str, '\n')

    call s:debug('Current TagStack len is '.len(tag_stack))
    call s:debug('GetTagStack() Done')

    return tag_stack
endfunction

function! s:GenContent(helpContent, tagStack)
    let content = a:helpContent
    
    call add(content, '')
    for i in range(0, s:tag_stack_ptr + 1)
        call add(content, a:tagStack[i])
    endfor

    return content
endfunction

" ======================================
" Controller 
" ======================================
function! new#JumpForward()
    call s:debug('JumpForward called')

    let currentWord = escape(expand('<cword>'), '\')
    call s:debug('Current word is '.currentWord)
    silent! execute 'tag '.currentWord
    let error_msg = 'E426: tag not found: '.currentWord
    if error_msg != v:errmsg
        let s:tag_stack_ptr += 1
        call s:Render()
    else
        echo v:errmsg
    endif
endfunction

function! new#JumpBackward()
    call s:debug('JumpBackward called')
    execute 'pop'
    let s:tag_stack_ptr -= 1
    call s:Render()
endfunction

function! new#ToggleHelp()
    let s:toggle_tag_stack_help = 1 - s:toggle_tag_stack_help 
endfunction