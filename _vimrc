if exists('g:vscode')
  " VSCode extension
else
  " ordinary Neovim

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
	else
		set runtimepath+=~/.nvim/bundle/neobundle.vim
		call neobundle#begin(expand('~/.nvim/bundle/'))
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

" clang-format.vim
" need clang-format-12 and executable link named `clang-format`
let g:clang_format_style="{BasedOnStyle: Google, IndentWidth: 4, Standard: C++11, AllowShortEnumsOnASingleLine: false, AlignTrailingComments: true, AllowShortBlocksOnASingleLine: Never, AllowShortCaseLabelsOnASingleLine: false, AllowShortFunctionsOnASingleLine: None, AlignConsecutiveAssignments: true, AlignConsecutiveDeclarations: true, AlignConsecutiveMacros: true, AlignEscapedNewlines: true, AlignTrailingComments: true, AllowAllArgumentsOnNextLine: true, AllowAllConstructorInitializersOnNextLine: true, AllowAllParametersOfDeclarationOnNextLine: true}"
nmap <C-f> <C-k>
vmap <C-f> <C-k>


