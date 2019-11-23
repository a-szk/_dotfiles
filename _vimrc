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

"シェルの指定(fishに変えた時にneobundleでバグった)
" if $SHELL =~ 'fish'
" 	set shell=/bin/sh
" endif

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
" 一旦しばらく:mksを使うことにします♨
" "後に書いてあるセッションを保存を行うために必要なプラグイン
" NeoBundle 'xolox/vim-session', {
"       \ 'depends' : 'xolox/vim-misc',
"       \ }	

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

	" :terminalで起動するshellの指定
	" set sh=fish

	" terminal mode中にコマンドモードの戻るためのデフォルトのキーバインドが<C-\><C-n>と厳しいのでESCにする
	tnoremap <silent> <ESC> <C-\><C-n>
	
	" deoplete
	let g:deoplete#enable_at_startup = 1 
endif

"plubin::lightline
if !has('gui_running')
	set t_Co=256
endif


" if has('nvim')
" 	"挿入モードでのカーソル移動(邪道という節もある)"
" 	inoremap <C-j> <Down>
" 	inoremap <C-k> <Up>
" 	inoremap <C-h> <Left>
" 	inoremap <C-l> <Right>
" endif
"easymotion
"
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

" 勝手にtex数式が本当の数式に変換されるやつ破壊したくなるので無効化
let g:tex_conceal=''

" vim-latex
let g:Tex_AutoFolding=0
let g:tex_flavor='platex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_FormatDependency_pdf='dvi,pdf'
let g:Tex_CompileRule_dvi='platex $*'
let g:Tex_CompileRule_pdf='dvipdfmx $*.dvi'
let g:Tex_ViewRule_pdf='evince'

" latex-suiteカスタマイズ
augroup MyIMAPs
  au!
" 例：
" EALの入力で
" \begin{align}
" <++>
" \label{eq:<++>}
" \end{align}<++>
" を出力する。
  " au VimEnter *.tex call IMAP('TIN','\begin{align}\<++>\\label{eq:<++>}\\end{align}<++>','tex')


" EM12で
" \begin{bmatrix}
" 	<++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM12','\begin{bmatrix}<++> & <++>\end{bmatrix}<++>','tex')
  
" EM21で
" \begin{bmatrix}
" 	<++>\\
" 	<++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM21','\begin{bmatrix}<++>\\<++>\end{bmatrix}<++>','tex')

" EM13で
" \begin{bmatrix}
" 	<++> & <++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM13','\begin{bmatrix}<++> & <++> & <++>\end{bmatrix}<++>','tex')

" EM31で
" \begin{bmatrix}
" 	<++>\\
" 	<++>\\
" 	<++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM31','\begin{bmatrix}<++>\\<++>\\<++>\end{bmatrix}<++>','tex')

" EM14で
" \begin{bmatrix}
" 	<++> & <++> & <++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM14','\begin{bmatrix}<++> & <++> & <++> & <++>\end{bmatrix}<++>','tex')

" EM41で
" \begin{bmatrix}
" 	<++>\\
" 	<++>\\
" 	<++>\\
" 	<++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM41','\begin{bmatrix}<++>\\<++>\\<++>\\<++>\end{bmatrix}<++>','tex')

" EM22で
" \begin{bmatrix}
" 	<++> & <++> \\
" 	<++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM22','\begin{bmatrix}<++> & <++> \\<++> & <++>\end{bmatrix}<++>','tex')

" EM33で
" \begin{bmatrix}
" 	<++> & <++> & <++> \\
" 	<++> & <++> & <++> \\
" 	<++> & <++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM33','\begin{bmatrix}<++> & <++> & <++> \\<++> & <++> & <++> \\<++> & <++> & <++>\end{bmatrix}<++>','tex')

" EM44で
" \begin{bmatrix}
" 	<++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM44','\begin{bmatrix}<++> & <++> & <++> & <++> \\<++> & <++> & <++> & <++> \\<++> & <++> & <++> & <++> \\<++> & <++> & <++> & <++>\end{bmatrix}<++>','tex')

" EM55で
" \begin{bmatrix}
" 	<++> & <++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> & <++> \\
" 	<++> & <++> & <++> & <++> & <++>
" \end{bmatrix}<++>
" を出力
  au VimEnter *.tex call IMAP('EM55','\begin{bmatrix}<++> & <++> & <++> & <++> & <++> \\<++> & <++> & <++> & <++> & <++> \\<++> <++> & & <++> & <++> & <++> \\<++> & <++> & <++> & <++> & <++>\\<++> & <++> & <++> & <++> & <++>\end{bmatrix}<++>','tex')
"Environment Equnarray contains Equal No-number
" EE(数字)で
" \begin{eqnarray}
"   <++>	&=&	<++>\\<++>\nonumber
" \end{eqnarray}<++>
" を数字個出力
  au VimEnter *.tex call IMAP('EE1','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE2','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE3','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE4','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE5','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE6','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE7','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE8','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')
  au VimEnter *.tex call IMAP('EE9','\begin{eqnarray}<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>	&=&	<++>	\nonumber\\<++>\end{eqnarray}<++>','tex')




"Environment Equnarray contains Equal Yes-number
" EEEYで
" \begin{eqnarray}
"   <++>	&	<++>\\
"   <++>	&	<++>\\
"   <++>	&	<++>
" \end{eqnarray}<++>\
" を出力
  au VimEnter *.tex call IMAP('EE33','\begin{eqnarray}<++>	&	<++>\\<++>	&	<++>\\<++>	&	<++>\end{eqnarray}<++>','tex')






" `pの入力で^/primeを書き込む，などなど
  " au VimEnter *.tex call IMAP('`p', '^\prime', 'tex') 
  " au VimEnter *.tex call IMAP('`P', '\prime', 'tex') 
  " au VimEnter *.tex call IMAP('`o', '\omega', 'tex') 
augroup END





" --------------------
"
"  vim-session
"
" --------------------
" " 現在のディレクトリ直下の .vimsessions/ を取得
" let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
" if isdirectory(s:local_session_directory)
"   " session保存ディレクトリをそのディレクトリの設定
"   let g:session_directory = s:local_session_directory
"   " vim終了時に自動保存
"   " let g:session_autosave = 'yes'
"   " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
"   let g:session_autoload = 'yes'
"   " 5分間に1回自動保存
"   " let g:session_autosave_periodic = 5
" else
"   let g:session_autosave = 'no'
"   let g:session_autoload = 'no'
" endif
" unlet s:local_session_directory


"和英・英和翻訳を行う"
function! s:DictionaryTranslate(...)
    let l:word = a:0 == 0 ? expand('<cword>') : a:1
    call histadd('cmd', 'DictionaryTranslate '  . l:word)
    if l:word ==# '' | return | endif
    let l:gene_path = '~/.vim/dict/gene.txt'
    let l:jpn_to_eng = l:word !~? '^[a-z_]\+$'
    let l:output_option = l:jpn_to_eng ? '-B 1' : '-A 1' " 和英 or 英和

    silent pedit Translate\ Result | wincmd P | %delete " 前の結果が残っていることがあるため
    setlocal buftype=nofile noswapfile modifiable
    silent execute 'read !grep -ihw' l:output_option l:word l:gene_path
    silent 0delete
    let l:esc = @z
    let @z = ''
    while search("^" . l:word . "$", "Wc") > 0 " 完全一致したものを上部に移動
        silent execute line('.') - l:jpn_to_eng . "delete Z 2"
    endwhile
    silent 0put z
    let @z = l:esc
    silent call append(line('.'), '==')
    silent 1delete
    silent wincmd p
endfunction
command! -nargs=? -complete=command DictionaryTranslate call <SID>DictionaryTranslate(<f-args>)

