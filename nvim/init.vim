" ================================================================
" Created by OrionPax on 2019/08/26
" Last Modified: 2019/12/23
"
" 1. 基础设置
"   - System
"   - Editor behavior
"   - Terminal Behaviors
" 2. 插件设置
"   - 移动
"   - 编辑
"   - Markdown
"   - 版本控制
"   - 增强
"   - 配置
" 3. 按键映射
"   - 移动
"   - 编辑
"   - Tab
"   - Screen
"   - Markdown
" ================================================================

" ================================================================
" 1. 基础设置
" ================================================================

" ---------------------------- System -----------------------------

"set clipboard=unnamedplus
let &t_ut=''
set autochdir

" ------------------------ Editor behavior ------------------------

set number
set relativenumber
set cursorline
set noexpandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set smartcase
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
" 隐藏标尺
" set colorcolumn=80
set updatetime=1000
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ------------------------ Terminal Behaviors ------------------------

let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'
augroup TermHandling
  autocmd!
  " Turn off line numbers, listchars, auto enter insert mode and map esc to
  " exit insert mode
  autocmd TermOpen * setlocal listchars= nonumber norelativenumber
    \ | startinsert
  autocmd FileType fzf call LayoutTerm(0.6, 'horizontal')
augroup END

function! LayoutTerm(size, orientation) abort
  let timeout = 16.0
  let animation_total = 120.0
  let timer = {
    \ 'size': a:size,
    \ 'step': 1,
    \ 'steps': animation_total / timeout
  \}

  if a:orientation == 'horizontal'
    resize 1
    function! timer.f(timer)
      execute 'resize ' . string(&lines * self.size * (self.step / self.steps))
      let self.step += 1
    endfunction
  else
    vertical resize 1
    function! timer.f(timer)
      execute 'vertical resize ' . string(&columns * self.size * (self.step / self.steps))
      let self.step += 1
    endfunction
  endif
  call timer_start(float2nr(timeout), timer.f, {'repeat': float2nr(timer.steps)})
endfunction

" Open autoclosing terminal, with optional size and orientation
function! OpenTerm(cmd, ...) abort
  let orientation = get(a:, 2, 'horizontal')
  if orientation == 'horizontal'
    new | wincmd J
  else
    vnew | wincmd L
  endif
  call LayoutTerm(get(a:, 1, 0.5), orientation)
  call termopen(a:cmd, {'on_exit': {j,c,e -> execute('if c == 0 | close | endif')}})
endfunction

" ================================================================
" 2. 插件设置
" ================================================================
" ===
" === Auto load for first time uses
" ===
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
" 	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
" 				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

call plug#begin('~/.config/nvim/plugged')

" ---------------------------- 移动 -----------------------------

" 全文快速移动，
" <leader><leader>s{char} 搜索跳转
" <leader><leader>w 跳转到后面的单词首字母
" <leader><leader>b 跳转到前面的单词首字母
Plug 'easymotion/vim-easymotion'

" 快速标记插件
" m[a-zA-Z] : 打标签
" '[a-zA-Z] : 跳转到标签位置
" '.        : 跳转到最后一次修改位置
" m<space>  : 去除所有标签
Plug 'kshenoy/vim-signature'

" 快速文件搜索
" :Files [PATH] : 搜索文件
" :GFiles [OPTS] : 搜索 Git 文件
" :Buffers : 打开缓冲区
" :History :  最近访问文件
" :Colors : Colors 切换
Plug 'junegunn/fzf', {'dir':'~/.fzf','do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

" ---------------------------- 编辑 -----------------------------

" 表格对齐，使用命令 Tabularize
" Shift + v 选中多行，使用:'<,'> Tab/{string} 按等号、冒号、表格对齐文本。
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" 成对编辑
" ys iw {char} 增加
" cs {oldChar} {newChat} 修改
" ds {char} 删除
Plug 'tpope/vim-surround'

" 用 v 选中一个区域后，alt_+/- 按分隔符扩大/缩小选区
Plug 'terryma/vim-expand-region'

" 文本替换
" :Far {pattern} {replace-with} {file-mask} [params] : 搜索并替换，使用 t 选择修改内容
" :F {pattern} {file-mask} [params] : 搜索
" :Fardo [params] : 确认修改
Plug 'brooth/far.vim'

" 文本格式化
" :Prettier : 格式化
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }

" 中文排版
" :Pangu
Plug 'hotoo/pangu.vim'

" 注释
" 选中 gc、gcc
Plug 'tpope/vim-commentary'

" ---------------------------- Markdown -------------------------

" 预览Markdown
" :MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install','for' :['markdown', 'vim-plug']}

" 生成TOC
" :GenTocMarked
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }

" 无序、有序列表自动补齐
Plug 'theniceboy/bullets.vim'

" ---------------------------- 版本控制 --------------------------

" Git 支持
Plug 'tpope/vim-fugitive'

" 用于在侧边符号栏显示 git/svn 的 diff
Plug 'mhinz/vim-signify'

" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'

" ---------------------------- 增强 ------------------------------

" 展示开始画面，显示最近编辑过的文件
Plug 'mhinz/vim-startify'

" 相对行号
Plug 'kennykaye/vim-relativity'

" 成对符号自动补全
" shift-tab 可以保持Insert模式跳到补全符号后面
Plug 'Raimondi/delimitMate'

" ---------------------------- 配置 ------------------------------

" MarkdownPreview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
      \ 'mkit': {},
      \ 'katex': {},
      \ 'uml': {},
      \ 'maid': {},
      \ 'disable_sync_scroll': 0,
      \ 'sync_scroll_type': 'middle',
      \ 'hide_yaml_meta': 1
      \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

" signify
let g:signify_vcs_list = ['git', 'svn']
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
let g:signify_sign_changedelete      = g:signify_sign_change
" git 仓库使用 histogram 算法进行 diff
let g:signify_vcs_cmds = {
    \ 'git': 'git diff --no-color --diff-algorithm=histogram --no-ext-diff -U0 -- %f',
  \}

call plug#end()

" ================================================================
" 3. 按键映射
" ================================================================

let mapleader=","
" ---------------------------- 移动 ------------------------------

" Ctrl + JK 快速移动
nnoremap <C-J> 5j
nnoremap <C-K> 5k

" ---------------------------- 编辑 ------------------------------

" 保存并格式化
nnoremap <C-S> :Prettier <Esc> :w<cr>h
inoremap <C-S> <Esc> :Prettier <Esc>:w<cr>i
 
" ALT_+/- 用于按分隔符扩大缩小 v 选区
" map <M-=> <Plug>(expand_region_expand)
" map <M--> <Plug>(expand_region_shrink)

" ---------------------------- Tab ------------------------------

" Create a new tab with tu
noremap tu :tabe<CR>

" <leader>+数字键 切换tab
noremap <silent><leader>1 1gt<cr>
noremap <silent><leader>2 2gt<cr>
noremap <silent><leader>3 3gt<cr>
noremap <silent><leader>4 4gt<cr>
noremap <silent><leader>5 5gt<cr>
noremap <silent><leader>6 6gt<cr>
noremap <silent><leader>7 7gt<cr>
noremap <silent><leader>8 8gt<cr>
noremap <silent><leader>9 9gt<cr>
noremap <silent><leader>0 10gt<cr>

" ---------------------------- Screen ------------------------------

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sh :set splitbelow<CR>:split<CR>
noremap sv :set nosplitright<CR>:vsplit<CR>:set splitright<CR>

" Resize splits with arrow keys
noremap <up> :res -5<CR>
noremap <down> :res +5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" ---------------------------- Markdown ------------------------------

"autocmd Filetype markdown map <leader>w yiWi[<esc>Ea](<esc>pa)
autocmd Filetype markdown inoremap <buffer> <leader>1 #<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <leader>2 ##<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <leader>3 ###<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <leader>4 ####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <leader>5 #####<Space><Enter><++><Esc>kA
autocmd Filetype markdown inoremap <buffer> <leader>f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
autocmd Filetype markdown inoremap <buffer> <leader>w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
autocmd Filetype markdown inoremap <buffer> <leader>l ---<Enter><Enter>
autocmd Filetype markdown inoremap <buffer> <leader>b **** <++><Esc>F*hi
autocmd Filetype markdown inoremap <buffer> <leader>w `` <++><Esc>F`i
autocmd Filetype markdown inoremap <buffer> <leader>c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
autocmd Filetype markdown inoremap <buffer> <leader>p ![](<++>) <++><Esc>F[a
autocmd Filetype markdown inoremap <buffer> <leader>a [](<++>) <++><Esc>F[a

" ---------------------------- 其他 ------------------------------

" 取消搜索标记
noremap <leader><CR> :nohlsearch<CR>

" Space to Tab
nnoremap <leader>tt :%s/    /\t/g
vnoremap <leader>tt :s/    /\t/g
