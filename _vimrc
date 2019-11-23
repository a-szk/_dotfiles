"set number
set relativenumber
set number

" カーソルを基本的に画面中央に保つ
set scrolloff=1000

set encoding=utf-8
set fileencodings=utf-8
"set fileencodings=iso-2022-jp,cp932,sjis,enc-jp,utf-8
set statusline=2
set laststatus=2

"全角記号打った時に重なるアレ
set ambiwidth=double

"オートインデント時のシフト幅(tabstopと同じにしておくといい)
set shiftwidth=4

"foldが現時点で邪魔だと感じたため
set nofoldenable

"不可視文字の表示
set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"set list
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab
set smarttab
set shiftround

" IMEがfcitxの場合に限り，全角入力からノーマルに戻ったときに半角に戻す
function! ImInActivate()
  call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

" inoremap <silent> jj <ESC>:call ImInActivate()<CR>
" inoremap <silent> っｊ <ESC>:call ImInActivate()<CR>

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
" NeoBundle 'Shougo/vimproc', {
" 	\ 'build' : {
" 	\ 'windows' : 'make -f make_mingw32.mak',
" 	\ 'cygwin' : 'make -f make_cygwin.mak',
" 	\ 'mac' : 'make -f make_mac.mak',
" 	\ 'unix' : 'make -f make_unix.mak',
" \ },
" \ }
"NeoBundle 'VimClojure'

NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
 let g:syntastic_enable_signs=1
 let g:syntastic_auto_loc_list=2
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

" lightliner? あとでググって

NeoBundle 'Shougo/neomru.vim'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'wikitopian/hardmode'
NeoBundle 'vim-latex/vim-latex'
NeoBundle 'nanotech/jellybeans.vim'
"	NeoBundle 'Shougo/neosnippet'
NeoBundle 'lazywei/vim-matlab'
NeoBundle 'derekwyatt/vim-scala'
"NeoBundle 'jpalardy/vim-slime'
NeoBundle 'vim-jp/cpp-vim'
" NeoBundleLazy 'vim-jp/cpp-vim', {
"             \ 'autoload' : {'filetypes' : 'cpp'}
"                         \ }
" Disable AutoComplPop.
 let g:acp_enableAtStartup = 0
 " Use neocomplcache.
 let g:neocomplcache_enable_at_startup = 1
" " Use smartcase.
 let g:neocomplcache_enable_smart_case = 1
" " Set minimum syntax keyword length.
 let g:neocomplcache_min_syntax_length = 3
 let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
" " Define dictionary.
 let g:neocomplcache_dictionary_filetype_lists = {
     \ 'default' : ''
         \ }

if has('nvim')
	NeoBundle 'Shougo/deoplete.nvim'
else
	NeoBundle 'Shougo/neocomplcache'
	" neocomplcache
	" Plugin key-mappings.
	inoremap <expr><C-g>     neocomplcache#undo_completion()
	inoremap <expr><C-l>     neocomplcache#complete_common_string()

	" Recommended key-mappings.
	" <CR>: close popup and save indent.
	inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
	function! s:my_cr_function()
	return neocomplcache#smart_close_popup() . "\<CR>"
	endfunction
	" <TAB>: completion.
	inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
	" <C-h>, <BS>: close popup and delete backword char.
	inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
	inoremap <expr><C-y>  neocomplcache#close_popup()
	inoremap <expr><C-e>  neocomplcache#cancel_popup()
	""NeoBundle 'https://bitbucket.org/kovisoft/slimv'

endif
call neobundle#end()

NeoBundleCheck
filetype plugin indent on     " required!
"filetype indent on
syntax on

"Neovim用の設定
if has('nvim')
	" 検索時のハイライト，ESCを連打したら消えるようにする
	nnoremap <ESC><ESC> :nohl<CR>

	" terminal mode中にコマンドモードの戻るためのデフォルトのキーバインドが<C-\><C-n>と厳しいのでESCにする
	tnoremap <silent> <ESC> <C-\><C-n>
	
	" deoplete
	let g:deoplete#enable_at_startup = 1 
endif

"plubin::lightline
if !has('gui_running')
	set t_Co=256
endif


"easymotion
"space使う設定を行った場合にはvisualmode中に
"space押すと一マス進んでしまい約立たないことがわかったので
"ノーマル，ビジュアル，選択モードの類ではspaceを無効化します
"あと，overwin系のコマンドは画面感の移動も含んでしまうために
"visual modeでの利用はできないです．
"easymotion-bd-fとかのコマンドならvisual modeでの利用が可能
noremap <space> <Nop>
map <space>p <Plug>(easymotion-prefix)
nmap <space>f <Plug>(easymotion-overwin-f2)
nmap <space>d <Plug>(easymotion-overwin-f)
vmap <space>f <Plug>(easymotion-bd-f2)
vmap <space>d <Plug>(easymotion-bd-f)
map <space>j <Plug>(easymotion-j)
map <space>k <Plug>(easymotion-k)
" 検索の代わりにeasymotionのn文字バージョンを持ってくる
map / <Plug>(easymotion-sn)

"tcomment
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif

if has('nvim')
	colorscheme jellybeans
endif

map <C-e> :NERDTreeToggle<CR>

function! s:clang_format()
  let now_line = line(".")
  exec ":%! clang-format"
  exec ":" . now_line
endfunction

if executable('clang-format')
  augroup cpp_clang_format
    autocmd!
    autocmd BufWrite,FileWritePre,FileAppendPre *.[ch]pp call s:clang_format()
  augroup END
endif

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

