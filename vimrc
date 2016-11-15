set number
set hlsearch
syntax on

set tags=/home/fjc/fbsource/fbcode/power/tags


execute pathogen#infect()
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


inoremap kj <Esc>
vnoremap kj <Esc>
imap <F2> GoDate: <Esc>:read !date<CR>kJ
cmap kj <Esc>

let mapleader = "-"

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>q :q!<cr>


set expandtab
set shiftwidth=2
set softtabstop=2
set autoindent

autocmd BufWritePre * :%s/\s\+$//e
let g:flake8_cmd="/usr/local/bin/flake8"

autocmd FileType python autocmd BufWritePost <buffer> call Flake8()
let g:flake8_show_in_gutter=1
let g:flake8_show_in_file=1

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_error_symbol = 'x'
let g:ycm_warning_symbol = '!'
let g:ycm_server_keep_logfiles = 1
let g:ycm_server_log_level = 'debug'
let g:ycm_global_ycm_extra_conf="~/.vim/bundle/YouCompleteMe/ycm_extra_conf.py"
let g:ycm_confirm_extra_conf = 0
nnoremap <leader>pg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>pd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>pc :YcmCompleter GoToDeclaration<CR>
