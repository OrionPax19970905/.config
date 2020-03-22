" ================================================================
" Created by OrionPax on 2019/08/26
" Last Modified: 2020/03/12
"
" 1. 基础设置
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

" ------------------------ Editor behavior ------------------------

" 设置显示行号
set number
" 设置相对行号
set relativenumber
" 设置光标下划线
set cursorline
" 一个tab等于多少个空格，当 expandtab的情况下，会影响在插入模式下按下<tab>键输入的空格，以及真正的 \t 用多少个空格显示
set tabstop=2
" 将 tab 转层空格
set expandtab
" noexpandtab 的情况下，tabstop 只会影响 \t 显示多少个空格（因为插入模式下按 <tab> 将会输入一个字符 \t
" set noexpandtab
" 使用 >> << 或 == 来缩进代码的时候补出的空格数。这个值也会影响 autoindent 自动缩进的值。
set shiftwidth=2
" insert 模式下，一个 tab 键按下后，展示成几个空格
set softtabstop=2
" 设置自动缩进
set autoindent
" 显示不可见字符
set list
" 设置 tab 和 空白符的显示方式
set listchars=tab:\|\ ,trail:▫
" 开启真彩色支持
set termguicolors
" 保持光标上下的最小行数
set scrolloff=4
" 在按下Esc后等待多长时间来决定是否还有输入.默认值为 1000 毫秒
set ttimeoutlen=0
" 设置键盘映射没有超时
set notimeout
" 设置需要折行
set wrap
" 设置 textwidth = 0 的话，就不会自动换行了，默认是" 78，超过这个数量的话按空格会自动换行
set tw=0
" 设置缩进方式
set indentexpr=
" 启用折叠 zc/zo 折叠和取消折叠
set foldenable
" 缩进折叠，相同的缩进中代码会被折叠
set foldmethod=indent
" 设置折叠级别
set foldlevel=99
" 设置格式化选项
set formatoptions-=tc
" 设置新分割窗口在右边
set splitright
" 设置新分割窗口在下边
set splitbelow
" 不在底部显示当前模式
set noshowmode
" 命令模式下，在底部显示，当前键入的指令
set showcmd
" 命令模式下，底部操作指令按下 Tab 键自动补全。第一次按下 Tab，会显示所有匹配的操作指令的清单；第二次按下 Tab，会依次选择各个指令。
set wildmenu
" 搜索时忽略大小写
set ignorecase
" 输入大写字符时大小写敏感
set smartcase
" 执行替换命令时将修改结果放到一个单独的窗口，执行 Esc 取消
set inccommand=split
" 设置 ctrl + n 自动补全的配置
set completeopt=longest,noinsert,menuone,noselect,preview
" 设置滚动屏幕更快
set ttyfast
" 设置滚动屏幕更快
set lazyredraw
" 出错时发出视觉提醒，通常是屏幕闪烁
set visualbell
" 设置文件备份
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif
" 隐藏标尺
" set colorcolumn=80
" 根据光标位置自动更新高亮 tag 的间隔时间，单位为毫秒
set updatetime=1000
" 普通模式光标的可移动位置，设置 onemore 可以移动到最后一个字符后
set virtualedit=block
" 打开文件跳转到最后编辑时的光标位置
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

call plug#begin('~/.config/nvim/plugged')

" ---------------------------- 显示 -----------------------------

" 展示开始画面，显示最近编辑过的文件
Plug 'mhinz/vim-startify'

" 将当前光标下的字符串，在文件所有用到的位置，标注展示
Plug 'rrethy/vim-illuminate'

" 在命令栏显示缓冲区列表
Plug 'bling/vim-bufferline'

" 一个好看的底部状态栏
Plug 'theniceboy/eleline.vim'

" 一个好看的配色方案
Plug 'ajmwagar/vim-deus'

" 每个变量都有不同的颜色
" <LEADER>sh 切换开启关闭
Plug 'jaxbot/semantic-highlight.vim'

" 显示颜色代码的真实颜色
Plug 'norcalli/nvim-colorizer.lua'

" 为括号添加不同的颜色
Plug 'luochen1990/rainbow'

" 更好看的 Tab Line
Plug 'mg979/vim-xtabline'

" ---------------------------- 移动 -----------------------------

" 全文快速移动，
" <LEADER><LEADER>s{char} 搜索跳转
" <LEADER><LEADER>w 跳转到后面的单词首字母
" <LEADER><LEADER>b 跳转到前面的单词首字母
Plug 'easymotion/vim-easymotion'

" 标签
" <C-B>              : 显示所有标签
" <LEADER>bt         : 打标签
" <LEADER>ba         : 加批注
" :ClearBookmarks    : 清除缓冲区文件所有标签
" :ClearAllBookmarks : 清除所有标签
Plug 'MattesGroeger/vim-bookmarks'

" 快速文件搜索
" :Files [PATH] : 搜索文件
" :GFiles [OPTS] : 搜索 Git 文件
" :Buffers : 打开缓冲区
" :History :  最近访问文件
" :Colors : Colors 切换
Plug 'junegunn/fzf', {'dir':'~/.fzf','do': { -> fzf#install() }}
Plug 'junegunn/fzf.vim'

" 在 NVIM 中使用 Ranger
" <C-F> 打开 Ragner
Plug 'francoiscabrol/ranger.vim'

" Plug 'liuchengxu/vista.vim'

" ---------------------------- 编辑 -----------------------------

" 表格对齐，使用命令 Tabularize
" Shift + v 选中多行，使用:'<,'> Tabularize/{string} 按等号、冒号、表格对齐文本。
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

" 成对编辑
" ys iw {char} 增加
" cs {oldChar} {newChat} 修改
" ds {char} 删除
Plug 'tpope/vim-surround'

" 文本替换
" :Far {pattern} {replace-with} {file-mask} [params] : 搜索并替换，使用 t 选择修改内容
" :F {pattern} {file-mask} [params] : 搜索
" :Fardo [params] : 确认修改
Plug 'brooth/far.vim'

" 中文排版
" :Pangu
Plug 'hotoo/pangu.vim'

" 注释
" 选中 gc、gcc
Plug 'tpope/vim-commentary'

" 代码片段
" <C-J> 使用代码片段/跳转到下一占位符
" <C-K> 跳转到上一占位符
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" 成对符号自动补全
Plug 'jiangmiao/auto-pairs'

" 使用 + - 放大缩小选中区域
Plug 'terryma/vim-expand-region'

" va=  visual after =
" ca=  change after =
" da=  delete after =
" ya=  yank after =
Plug 'junegunn/vim-after-object'

" <LEADER>ssip 替换当前段落中光标下方的单词
Plug 'svermeulen/vim-subversive'

" 格式化
" :Prettier 格式化代码
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

" -------------------------- 文件类型支持 -------------------------

" JSON 高亮
Plug 'elzr/vim-json'

" JavaScript 高亮
Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }

" JSX 高亮
Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }

" Markdown
" :MarkdownPreview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install','for' :['markdown', 'vim-plug']}

" 生成TOC
" :GenTocMarked
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }

" 无序、有序列表自动补齐
Plug 'theniceboy/bullets.vim'

" ---------------------------- 版本控制 --------------------------

" Git 支持
" <C-G> 仅显示修改代码段，其他折叠
" <LEADER>gp 展示修改内容
" <LEADER>gj 跳转到下一处修改
" <LEADER>gk 跳转到上一处修改
Plug 'airblade/vim-gitgutter'

" :FzfGitignore
" 从 https://www.gitignore.io/ 上创建 .gitignore 文件
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }

" 本地修改历史
" <C-U> 打开本地文件修改历史
Plug 'mbbill/undotree'

" ------------------------- 其他编辑器增强 ------------------------------

" 输入 " 时显示寄存器内容
Plug 'junegunn/vim-peekaboo'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" VIM 终端增强
Plug 'wincent/terminus'

" 向其他 VIM 插件添加文件类型的符号
Plug 'ryanoasis/vim-devicons'

call plug#end()

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

" GitGutter
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1

" 设置 deus 配色
colorscheme deus

" semantic-highlight
autocmd BufRead * :SemanticHighlightToggle

" nvim-colorizer 显示 #FEDC56 这种颜色字符的真实颜色
lua require'colorizer'.setup()

" ranger.vim
let g:ranger_map_keys = 0

" Vista.vim
" noremap <silent> T :Vista!!<CR>
" let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
" let g:vista_default_executive = 'ctags'
" let g:vista_fzf_preview = ['right:50%']
" let g:vista#renderer#enable_icon = 1
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
" function! NearestMethodOrFunction() abort
"		return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" Ultisnips
let g:tex_flavor = "latex"
let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/my-ultisnips/', 'UltiSnips']

" Undotree
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24

" vim-after-object
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" vim-bookmarks
let g:bookmark_no_default_key_mappings = 1
let g:bookmark_auto_save = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_center = 1
let g:bookmark_auto_close = 1

" rainbow
let g:rainbow_active = 1

" xtabline
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1


" ================================================================
" 3. 按键映射
" ================================================================

let mapleader=" "
" ---------------------------- 移动 ------------------------------

" Ctrl + JK 快速移动
nnoremap <S-J> 5j
nnoremap <S-K> 5k

" ---------------------------- 编辑 ------------------------------

" 保存并格式化
nnoremap <C-S> :w<cr>h
inoremap <C-S> <Esc>:w<cr>i
autocmd Filetype markdown nnoremap <C-S> :Prettier<Esc>:w<cr>h
autocmd Filetype markdown inoremap <C-S> <Esc> :Prettier<Esc>:w<cr>i

" 空格转 Tab
nnoremap stt :%s/    /\t/g
vnoremap stt :s/    /\t/g

" Tab 转空格
nnoremap tts :%s/\t/    /g
vnoremap tts :s/\t/    /g

" 普通模式按一下 </> 缩进
nnoremap < <<
nnoremap > >>

" 禁用 s 键
noremap s <nop>

" ---------------------------- Tab ------------------------------

" 创建 Tab
noremap tab :tabe<CR>

" <LEADER>+数字键 切换tab
noremap <silent><LEADER>1 1gt<cr>
noremap <silent><LEADER>2 2gt<cr>
noremap <silent><LEADER>3 3gt<cr>
noremap <silent><LEADER>4 4gt<cr>
noremap <silent><LEADER>5 5gt<cr>
noremap <silent><LEADER>6 6gt<cr>
noremap <silent><LEADER>7 7gt<cr>
noremap <silent><LEADER>8 8gt<cr>
noremap <silent><LEADER>9 9gt<cr>
noremap <silent><LEADER>0 10gt<cr>

" --------------------------- Buffers -----------------------------

" <LEADER><LEADER>+数字键 切换 Buffers
noremap <silent><LEADER><LEADER>1 :b1<cr>
noremap <silent><LEADER><LEADER>2 :b2<cr>
noremap <silent><LEADER><LEADER>3 :b3<cr>
noremap <silent><LEADER><LEADER>4 :b4<cr>
noremap <silent><LEADER><LEADER>5 :b5<cr>
noremap <silent><LEADER><LEADER>6 :b6<cr>
noremap <silent><LEADER><LEADER>7 :b7<cr>
noremap <silent><LEADER><LEADER>8 :b8<cr>
noremap <silent><LEADER><LEADER>9 :b9<cr>

" ---------------------------- Screen ------------------------------

" sh / sv 分屏
noremap sh :set nosplitbelow<CR>:split<CR>
noremap sv :set nosplitright<CR>:vsplit<CR>:set splitright<CR>

" 移动分屏线
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" 分屏 <LEADER> + h/j/k/l 屏幕间切换
nnoremap <LEADER>h <C-W>h
nnoremap <LEADER>j <C-W>j
nnoremap <LEADER>k <C-W>k
nnoremap <LEADER>l <C-W>l

" ---------------------------- Markdown ------------------------------

" 使用 Snippets
" autocmd Filetype markdown inoremap <buffer> <LEADER>1 #<Space><Enter><++><Esc>kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>2 ##<Space><Enter><++><Esc>kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>3 ###<Space><Enter><++><Esc>kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>4 ####<Space><Enter><++><Esc>kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>5 #####<Space><Enter><++><Esc>kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>f <Esc>/<++><CR>:nohlsearch<CR>"_c4l
" autocmd Filetype markdown inoremap <buffer> <LEADER>w <Esc>/ <++><CR>:nohlsearch<CR>"_c5l<CR>
" autocmd Filetype markdown inoremap <buffer> <LEADER>l ---<Enter><Enter>
" autocmd Filetype markdown inoremap <buffer> <LEADER>b **** <++><Esc>F*hi
" autocmd Filetype markdown inoremap <buffer> <LEADER>w `` <++><Esc>F`i
" autocmd Filetype markdown inoremap <buffer> <LEADER>c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA
" autocmd Filetype markdown inoremap <buffer> <LEADER>p ![](<++>) <++><Esc>F[a
" autocmd Filetype markdown inoremap <buffer> <LEADER>a [](<++>) <++><Esc>F[a

" ---------------------------- 插件 ------------------------------

" semantic-highlight
nnoremap <LEADER>sh :SemanticHighlightToggle<CR>

" ranger.vim
nnoremap <silent> <C-F> :RangerNewTab<CR>

" Ultisnips
inoremap <C-N> <nop>
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"

" Undotree
noremap <C-U> :UndotreeToggle<CR>
function g:Undotree_CustomMap()
	nmap <buffer> j <plug>UndotreeNextState
	nmap <buffer> k <plug>UndotreePreviousState
	nmap <buffer> <S-J> 5<plug>UndotreeNextState
	nmap <buffer> <S-K> 5<plug>UndotreePreviousState
endfunc

" GitGutter
nnoremap <C-G> :GitGutterFold<CR>
nnoremap <LEADER>gp :GitGutterPreviewHunk<CR>
nnoremap <LEADER>gk :GitGutterPrevHunk<CR>
nnoremap <LEADER>gj :GitGutterNextHunk<CR>

" vim-subversive
nmap <LEADER>ss <plug>(SubversiveSubstituteWordRange)

" vim-bookmarks
nmap <C-B> <Plug>BookmarkShowAll
nmap <LEADER>bt <Plug>BookmarkToggle
nmap <LEADER>ba <Plug>BookmarkAnnotate

" ---------------------------- 其他 ------------------------------

" 打开 NVIM 的配置文件
noremap grc :e ~/.config/nvim/init.vim<CR>

" 取消搜索标记
noremap ns :nohlsearch<CR>

" 视图模式复制到系统剪切板
vnoremap y "+y

