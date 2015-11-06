" ======================================
" Model  
" ======================================
let s:tag_stack_ptr = -1 " tag stack pointer points to the index of last tag
let s:toggle_tag_stack = 1
let s:toggle_tag_stack_visibility = 1
let s:toggle_tag_stack_help = 0
let s:toggle_debug = 0

let s:tag_stack_buf_name = '__call_stack__'
let s:debug_file = 'reaser.log'

let s:source_file_win = ''

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

    let tag_stack_winnr = bufwinnr(s:tag_stack_buf_name)
    if tag_stack_winnr == -1
        return
    endif

    if winnr() == tag_stack_winnr
        if tag_stack_winnr == 1
            execute 'quit'
        else
            close
        endif
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

    let cur_winnr = winnr()

    call s:CloseWin()
    let help_content = s:GetHelpContent()
    let tag_stack = s:GetTagStack()

    if s:toggle_tag_stack && s:toggle_tag_stack_visibility && s:tag_stack_ptr >= 0

        let content = s:GenContent(help_content, tag_stack) 
        let split_win_cmd = 'silent keepalt ' . (len(content)). 'split' . s:tag_stack_buf_name
        set splitbelow
        execute split_win_cmd 
        setlocal modifiable

        execute "normal ggdG"

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

        execute 'nnoremap <script> <silent> <buffer> ? :call jump#ToggleHelp()<Cr>'

    endif

    call s:GoToWin(cur_winnr)

    call s:debug('Render() Done')
endfunction

function! s:GetHelpContent()
    if s:toggle_tag_stack_help == 0
        return ['" press ? for help']
    else
        let help_content = []
        let help_content += ['" Reasier Keybindings']
        let help_content += ['" <leader>t: Toggle tag stack']
        let help_content += ['" <leader>f: High light current word']
        let help_content += ['" Complete one: https://github.com/fmars/reasier']
        return help_content
    endif
endfunction

function! s:GetTagStack()
    call s:debug('GetTagStack() Start ')

    execute 'redir => tag_stack_str'
    execute 'silent tags'
    redir END
    let tag_stack = split(tag_stack_str, '\n')

    call s:debug('Current TagStack is '.string(tag_stack))
    call s:debug('GetTagStack() Done')

    return tag_stack
endfunction

function! s:GenContent(helpContent, tagStack)
    call s:debug('GetContent() Start ')
    let content = a:helpContent
    
    let content += ['']
    for i in range(0, s:tag_stack_ptr + 1)
        let content += [a:tagStack[i]]
    endfor

    call s:debug('Current Content is '.string(content))
    call s:debug('GetContent() Done ')
    return content
endfunction

" ======================================
" Controller 
" ======================================
function! jump#JumpForward()
    call s:debug('JumpForward called')

    let currentWord = escape(expand('<cword>'), '\')
    if s:toggle_tag_stack == 0
        execute 'tag '.currentWord
    else
        call s:debug('Current word is '.currentWord)

        " silent! execute 'tag '.currentWord 
        " comment out silent execute because the case of
        " multiple entries for one tag 
        " user input is needed

        " let error_msg = 'E426: tag not found: '.currentWord
        " comment out E426 because not only E426 will result
        " into tag not found 
        " instead we directly check if 'not found' in errmsg
        
        let error_msg_sign = 'not found'
        execute 'tag '.currentWord
        if stridx(v:errmsg, error_msg_sign) == -1
            let s:tag_stack_ptr += 1
            call s:Render()
        else 
            let v:errmsg = ''
            " reset v:errmsg to avoid remained value effect 
            " next time condition check
        endif
    endif
endfunction

function! jump#JumpBackward()
    call s:debug('JumpBackward called')
    if s:toggle_tag_stack == 0
        execute 'pop'
    else
        if s:tag_stack_ptr >= 0
            execute 'pop'
            let s:tag_stack_ptr -= 1
            call s:Render()
        endif
    endif
endfunction

function! jump#ToggleHelp()
    let s:toggle_tag_stack_help = 1 - s:toggle_tag_stack__help 
    call s:Render()
endfunction

function! jump#ToggleTagStack()
    let s:toggle_tag_stack = 1 - s:toggle_tag_stack
    echom 'TagStack Toggle = '.string(s:toggle_tag_stack)
    call s:Render()
endfunction

function! jump#ToggleTagStackVisibility()
    let s:toggle_tag_stack_visibility = 1 - s:toggle_tag_stack_visibility
    echom 'TagStackVisibility Toggle = '.string(s:toggle_tag_stack_visibility)
    call s:Render()
endfunction

function! jump#ToggleDebug()
    let s:toggle_debug = 1 - s:toggle_debug
endfunction

" ======================================
" auto close
" ======================================
function! jump#AutoClose()
    call s:debug('AutoClose called')
    let tag_stack_winnr = bufwinnr(s:tag_stack_buf_name)
    call s:debug('Current tag_stack_winnr = '.string(tag_stack_winnr))
    if tag_stack_winnr == -1
        return
    endif
    if tag_stack_winnr == 1
        call s:CloseWin()
    endif
    call s:debug('AutoClose done')
endfunction


