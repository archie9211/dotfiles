" This must be first, because it changes other options as a side effect.
set nocompatible
filetype off
set encoding=utf-8
" ================ General Config ====================
"
"
set number                      "Line numbers are good
set backspace=indent,eol,start  "Allow backspace in insert mode
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set autoread                    "Reload files changed outside vim
set mouse=a

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
"set hidden

"turn on syntax highlighting
syntax on

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab

" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
"dowload vim plug in ~/.vim
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin('~/.vim/plugged')

" Cool plugins
Plug 'Valloric/YouCompleteMe'

"Plug 'google/vim-maktaba'
"Plug 'google/vim-codefmt'
"Plug 'google/vim-glaive'
"Plug 'lervag/vimtex'
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
"Plug 'skywind3000/asyncrun.vim'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'
"Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'tomasiser/vim-code-dark'
Plug 'sjl/badwolf'
Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'yggdroot/indentLine'
Plug 'mattn/emmet-vim'

"Plug 'vim-scripts/conque-GDB'

"Plug 'Shougo/deoplete.nvim'
"Plug 'roxma/nvim-yarp'
"Plug 'roxma/vim-hug-neovim-rpc'

call plug#end()
"call glaive#Install()
filetype plugin indent on 
syntax enable

colorscheme badwolf
"set background=dark "setting dark mode
"let g:gruvbox_underline = '1'
"let g:gruvbox_contrast_dark = 'dark'

"airline
set noshowmode
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1


"split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent

" setup for ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_complete_in_comments_and_strings=1
let g:ycm_autoclose_preview_window_after_insertion = 1

"" turn on completion in comments
let g:ycm_complete_in_comments=1
"" load ycm conf by default
let g:ycm_confirm_extra_conf=0
"" turn on tag completion
let g:ycm_collect_identifiers_from_tags_files=1
"" only show completion as a list instead of a sub-window
set completeopt-=preview
"" start completion from the first character
let g:ycm_min_num_of_chars_for_completion=1
"" don't cache completion items
let g:ycm_cache_omnifunc=0
"" complete syntax keywords
let g:ycm_seed_identifiers_with_syntax=1

nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nmap <leader>gd     :YcmDiags<CR>

let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_semantic_triggers =  {
            \ 'c' : ['re!\w{2}'],
            \ 'cpp' : ['re!\w{2}'],
            \ 'python' : ['re!\w{2}'],
            \ }

"text formatting
"augroup autoformat_settings
"    autocmd FileType proto,javascript AutoFormatBuffer clang-format
"    autocmd FileType python AutoFormatBuffer yapf
"augroup END
" use google style for clang-format
"Glaive codefmt clang_format_style='google'

" setup for indent line
let g:indentLine_char = '|'

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
"nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
"nmap <leader>bl :ls<CR>
"tabs
"map <C-t> :tabn<cr>

"NERDTree settings
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap <Leader>f :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
let NERDTreeQuitOnOpen = 1

" Better search
set hlsearch
set incsearch

autocmd FocusLost * silent! wa " Automatically save file

set scrolloff=5 " Keep 5 lines below and above the cursor

set cursorline

set laststatus=2
set statusline=%f "tail of the filename
set statusline+=\ c:%c

autocmd VimResized * wincmd = " Automatically resize splits when resizing window

"too convinient
nnoremap ; : 

"vim delay
set timeoutlen=1000 ttimeoutlen=0

"deoplete
"let g:deoplete#enable_at_startup = 1
"deoplete-tab
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Customize fzf colors to match your color scheme
"let g:fzf_colors =
"            \ { 'fg':      ['fg', 'Normal'],
"            \ 'bg':      ['bg', 'Normal'],
"            \ 'hl':      ['fg', 'Comment'],
"            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"            \ 'hl+':     ['fg', 'Statement'],
"            \ 'info':    ['fg', 'PreProc'],
"            \ 'prompt':  ['fg', 'Conditional'],
"            \ 'pointer': ['fg', 'Exception'],
"            \ 'marker':  ['fg', 'Keyword'],
"            \ 'spinner': ['fg', 'Label'],
"            \ 'header':  ['fg', 'Comment'] }
"let g:asyncrun_open = 1
map <F5> :<C-U>!g++ -O2 -DLOCAL -std=c++14 -g -Wall -Wextra -Wno-unused-result -static %:r.cpp -o %:r<CR>
map <F9> :<C-U>!./%:r<CR>
"AsyncRun window
let g:asyncrun_open = 8


"conque gdb
"let g:ConqueTerm_Color = 1         " 1: strip color after 200 lines, 2: always with color
"let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
"let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly  
"let g:ConqueTerm_Interrupt = '<C-g><C-c>'
"let g:ConqueTerm_ReadUnfocused = 1
