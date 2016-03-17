"viと互換にしない
set nocompatible
"not create backup files
set noswapfile
set nowritebackup
set nobackup

"default character code
set fenc=utf-8

"アンドゥ情報を保存しない
set noundofile
"クリップボード有効
set clipboard+=unnamed,autoselect
"左右キーで次/前の行に移動可能
set whichwrap=b,s,[,],<,>
"バックスペースで前の行に戻れる
set backspace=indent,eol,start
"全角文字幅に対応
set ambiwidth=double
"
set wildmenu
"マウスを有効
if has('mouse')
  set mouse=a
endif
"ビープを鳴らさない
set visualbell t_vb=

"検索時に大文字小文字を区別しないが混在するときは考慮する
set ignorecase
set smartcase
"ファイルの末尾に達したら、先頭から再び検索
set wrapscan
"インクリメントサーチを有効
set incsearch
"ヒットしたワードをハイライト
set hlsearch

"行番号を表示
set number
"ファイル名を表示
set title
"オートインデント有効
set autoindent
"対応する括弧を強調表示
set showmatch
"タブを空白2つ分に
set tabstop=2
set expandtab
set shiftwidth=2
"シンタックスハイライトをオン
syntax on
"コマンド行を2行に
set cmdheight=2
set laststatus=2
"コマンドを表示
set showcmd
"
set display=lastline
"余計な空白を~で示す
set list
set listchars=tab:^\ ,trail:~

set term=xterm
"set term=ansi
"set term=pcansi
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"

"NeoBundleの設定
if has('vim_starting')
  set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('$HOME/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

"unite.vim
NeoBundle 'Shougo/unite.vim'

"vimproc
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw64.mak',
    \ 'linux' : 'make',
  \ },
\ }

"補完プラグイン
NeoBundle 'Shougo/neocomplete'
let g:neocomplete#enable_at_startup=1
" Use smartcase
let g:neocomplete#enable_smart_case=1
" Set minimum syntax keyword length
let g:neocomplete#sources#syntax#min_keyword_length=3
let g:neocomplete#lock_buffer_name_pattern='\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
\ }
" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns={}
endif
let g:neocomplete#keyword_patterns['default']='\h\w*'
" Plugin key-mappings.
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

"Powerline的なやつ
NeoBundle 'itchyny/lightline.vim'

let g:lightline = {
        \ 'colorscheme': 'hybrid',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

NeoBundle 'cocopon/colorswatch.vim'
NeoBundle 'cocopon/lightline-hybrid.vim'

"ファイルブラウザを\eで表示するための設定
NeoBundle 'scrooloose/nerdtree'
map <silent> <Leader>e :NERDTreeToggle<cr>

"emmet-vim, いわゆるZen Coding
NeoBundle 'mattn/emmet-vim'

"Markdownなどのプレビューに
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

"Syntax Highlight
"ES6
NeoBundle 'othree/yajs.vim'
"TypeScript
NeoBundle 'leafgarland/typescript-vim'
"HTML5
NeoBundle 'othree/html5.vim'
"CSS3
NeoBundle 'hail2u/vim-css3-syntax'
"Markdown
NeoBundle 'tpope/vim-markdown'
"Markdown関連設定
"連番生成（\nr）
function! s:vnr() range
  let n=1
  for i in range(a:firstline, a:lastline)
    call setline(i, n.'. '.getline(i))
    let n+=1
  endfor
endfunction
vnoremap <leader>nr :call <SID>vnr()<cr>
"リンク生成（\mdu）
vnoremap <leader>mdu ygvs[](<c-r>")<esc>?[]<cr>a
"コードブロックのシンタックスハイライト
let g:markdown_fenced_languages = [
      \ 'html',
      \ 'css',
      \ 'erb=eruby',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript',
      \ 'ruby',
      \ 'sass',
      \ 'xml',
      \ ]

"Color Scheme
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'jpo/vim-railscasts-theme'
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'fcevado/molokai_dark'
NeoBundle 'thomd/vim-wasabi-colorscheme'

"インデントレベルを見やすく
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=darkgrey

call neobundle#end()

filetype plugin indent on

NeoBundleCheck

colorscheme railscasts
