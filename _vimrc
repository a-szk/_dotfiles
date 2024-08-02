if exists('g:vscode')
  " VSCode extension
else
  " ordinary Neovim

  "set line feed code
  set fileformats=unix

  "set number
  set relativenumber
  set number
  " カーソルを基本的に画面中央に保つ
  set scrolloff=1000
  
  set encoding=utf-8
  set fileencodings=utf-8
  " set fileencodings=iso-2022-jp,cp932,sjis,enc-jp,utf-8
  set statusline=2
  set laststatus=2
  
  "全角記号
  set ambiwidth=double
  
  "オートインデント時のシフト幅(tabstopと同じにしておくといい)
  set shiftwidth=4
  
  "foldが現時点で邪魔だと感じたため
  set nofoldenable
  
  "不可視文字の表示
  set list
  set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
  
  "set list
  set tabstop=4
  set shiftwidth=4
  set softtabstop=0
  set expandtab
  set smarttab
  set shiftround
endif

" 固定レジスタ
call setreg('x', '<?xml version="1.0"?>') " for launch
call setreg('m', "% --- + - * /, (1 == 1), (1 >= 1), (1 <= 1), (1 ~= -1), '../', '-', -except variable, --- ") " for matlab formatter

" カーソルを基本的に画面中央に保つ
set scrolloff=1000

" clipboardを共有
set clipboard=unnamed,unnamedplus

"全角スペースをハイライト表示　
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction


" 全角スペースの可視化
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'

"neobundle
set nocompatible
filetype off

if has('vim_starting')
  if !has('nvim')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    if has('persistent_undo')
        set undodir=~/.vim/undo
        set undofile
    endif
  else
    set runtimepath+=~/.nvim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.nvim/bundle/'))
    if has('persistent_undo')
        set undodir=~/.nvim/undo
        set undofile
    endif
  endif
endif

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'vim-jp/cpp-vim'
NeoBundle 'cjuniet/clang-format.vim'

" for lint
NeoBundle 'scrooloose/syntastic'

" for matlab foramtter
" NeoBundle 'junegunn/vim-easy-align'

call neobundle#end()

NeoBundleCheck
filetype plugin indent on     " required!
syntax on


"Neovim用の設定
if has('nvim')
  " 検索時のハイライト，ESCを連打したら消えるようにする
  nnoremap <ESC><ESC> :nohl<CR>

  " terminal mode中にコマンドモードの戻るためのデフォルトのキーバインドが<C-\><C-n>と厳しいのでESCにする
  tnoremap <silent> <ESC> <C-\><C-n>
endif

if !has('gui_running')
  set t_Co=256
endif

noremap <space> <Nop>
map <space>p <Plug>(easymotion-prefix)
nmap <space>f <Plug>(easymotion-overwin-f2)
nmap <space>d <Plug>(easymotion-overwin-f)
vmap <space>f <Plug>(easymotion-bd-f2)
vmap <space>d <Plug>(easymotion-bd-f)
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)

"tcomment
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif

colorscheme jellybeans

""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
" """"""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""

map <C-e> :NERDTreeToggle<CR>

nmap <C-f> <Nop>
vmap <C-f> <Nop>

" clang-format.vim
" need clang-format-6.0 and executable link named `clang-format`
autocmd BufRead *.c,*.h,*.cpp,*.hpp let g:clang_format#style_options = {
            \ "Language" : "Cpp",
            \ "BasedOnStyle" : "Google",
            \ "AlignConsecutiveAssignments" : "true",
            \ "AllowShortFunctionsOnASingleLine" : "Empty",
            \ "AllowShortIfStatementsOnASingleLine" : "false",
            \ "AllowShortLoopsOnASingleLine" : "false",
            \ "BreakBeforeBinaryOperators" : "NonAssignment",
            \ "BreakConstructorInitializers" : "AfterColon",
            \ "ColumnLimit" : "80",
            \ "ConstructorInitializerAllOnOneLineOrOnePerLine" : "true",
            \ "DerivePointerAlignment" : "false",
            \ "ReflowComments" : "false",
            \ "SortIncludes" : "true",
            \ "SortUsingDeclarations" : "true",
            \ "SpaceAfterTemplateKeyword" : "false"}
nmap <C-f> <C-k>
vmap <C-f> <C-k>

nmap <C-k> <Nop>
vmap <C-k> <Nop>

" Autopep8, need `pip3 install autopep8`
" nmap <F8> <Nop>
" vmap <F8> <Nop>
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction
function! Autopep8()
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction
autocmd BufRead *.py,*.cfg nnoremap <C-k> :call Autopep8()<CR>

" Matlab Formatter
autocmd BufRead *.m nmap <C-Z> :%s/ *+ */ + /g<CR>:%s/ *- */ - /g<CR>:%s/ *\* */ * /g<CR>:%s; */ *; / ;g<CR>:%s/ *, */, /g<CR>:%s/ *> */ > /g<CR>:%s/ *< */ < /g<CR>:%s/ *\~ */ \~ /g<CR>:%s/ *= */ = /g<CR><ESC><ESC>
autocmd BufRead *.m vmap <C-Z> :%s/ *+ */ + /g<CR>:%s/ *- */ - /g<CR>:%s/ *\* */ * /g<CR>:%s; */ *; / ;g<CR>:%s/ *, */, /g<CR>:%s/ *> */ > /g<CR>:%s/ *< */ < /g<CR>:%s/ *\~ */ \~ /g<CR>:%s/ *= */ = /g<CR><ESC><ESC>
autocmd BufRead *.m nmap <C-X> :%s/-  -/--/g<CR>:%s/=  =/==/g<CR>:%s/< =/<=/g<CR>:%s/> =/>=/g<CR>:%s/\~ =/\~=/g<CR>:%s; / ';/';g<CR>
autocmd BufRead *.m vmap <C-X> :%s/-  -/--/g<CR>:%s/=  =/==/g<CR>:%s/< =/<=/g<CR>:%s/> =/>=/g<CR>:%s/\~ =/\~=/g<CR>:%s; / ';/';g<CR>
autocmd BufRead *.m nmap <C-C> :%s/-  -/--/g<CR>:%s/- except /-except /g<CR>:%s/% */% /g<CR>:%s/' - /'-/g<CR>
autocmd BufRead *.m vmap <C-C> :%s/-  -/--/g<CR>:%s/- except /-except /g<CR>:%s/% */% /g<CR>:%s/' - /'-/g<CR>
autocmd BufRead *.m nmap <C-V> :%s/\v([,=(;[] *)([-+]) ([0-9]+)([,)])/\1\2\3\4/g<CR>
autocmd BufRead *.m vmap <C-V> :%s/\v([,=(;[] *)([-+]) ([0-9]+)([,)])/\1\2\3\4/g<CR>

autocmd BufRead *.m nmap <C-f> <C-Z><C-X><C-C><C-V>
autocmd BufRead *.m vmap <C-f> <C-Z><C-X><C-C><C-V>


