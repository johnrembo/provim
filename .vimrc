" General defaults

scriptencoding utf-8
set encoding=utf-8

" tmux compatibility
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

set termguicolors      " Use terminal emulator palette
set t_Co=256		   " Enable 256 color support
set nocompatible       " Forget old vi
set showcmd            " Show (partial) command in status line.
set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
set smartcase          " Do smart case matching
set incsearch          " Incremental search
set autowrite          " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a            " Enable mouse usage (all modes)
set number             " Show line numbers
set relativenumber     " Use relative line number to cursor
set tabstop=4          " A tab is four spaces
set softtabstop=4      " When hitting <BS>, pretend like a tab is removed, even if spaces
set noexpandtab        " Don't expand tabs to spaces by default
set shiftwidth=4       " Number of spaces to use for autoindenting
set shiftround         " Use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " Allow backspacing over everything in insert mode
set autoindent         " Always set autoindenting on
set copyindent         " Copy the previous indentation on autoindenting
set nolist			   " White space characters
set listchars=eol:$,tab:.\ ,trail:.,extends:>,precedes:<,nbsp:_ " Compatible space chars
set wrap linebreak	   " Soft wrap long lines
set whichwrap+=[,],h,l " Allow jump between lines when on start or end of line
set path+=**		   " Fuzzy search in command line
set wildmenu		   " Tab completion menu
set cursorline		   " Highlight line with cursor
set noshowmode		   " Hide mode indicator, duplicated by status line plugin
set undofile		   " Keep undo history between sessions
set undodir=~/.vim/undo/     " Keep undo files out of file dir
set directory=~/.vim/swp/  	 " Keep unsaved changes away from file dir
set backupdir=~/.vim/backup/ " Backups also should not go to git


syntax enable		   " Enable syntax highlighting
filetype on            " Enable filetype plugin
colorscheme desert	   " Default until full colorscheme loaded

" Keyboard defaults

let mapleader = " " " Map leader to Space

set keymap=russian-jcukenwin " Russian layout (toggle <C-^>)
set iminsert=0 " Чтобы при старте ввод был на английском, а не русском (start > i)
set imsearch=0 " Чтобы при старте поиск был на английском, а не русском (start > /)

" no indent on paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" display white space characters with F3
nnoremap <F3> :set list! list?<CR>

" toggle line numbers
nnoremap <F4> :set rnu! \| set nu!<CR>

" display white space characters with F3
nnoremap <F3> :set list! list?<CR>

" toggle line numbers
nnoremap <F4> :set rnu! \| set nu!<CR>

" esc in insert & visual mode
inoremap \' <esc>
vnoremap \' <esc>
inoremap \э <esc>
vnoremap \э <esc>

" turn off ins mode toggle
inoremap <Insert> <Esc>

" clear search highlights
map <leader>nh :noh<CR>

" increment/decrements numbers
map <leader>+ <C-a>
map <leader>- <C-x>

" move between soft wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <expr> <Down> v:count ? 'j' : 'gj'
nnoremap <expr> <Up> v:count ? 'k' : 'gk'

" stay in insert mode after indent
vnoremap <silent>< <gv
vnoremap <silent>> >gv

" windows
map <leader>wv <C-w>v
map <leader>wh <C-w>s
map <leader>we <C-w>=
map <leader>wx <C-w>c

" buffers
map <leader>bo :new<CR> 
map <leader>bd :bdelete<CR>
map <leader>bn :bn<CR>
map <leader>bp :bp<CR>

" tabs
map <leader>to :tabnew<CR> 
map <leader>tx :tabclose<CR>
map <leader>tn :tabn<CR>
map <leader>tp :tabp<CR>

" shift arrow like gui
nmap <S-Up> v<Up>
nmap <S-Down> v<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
imap <S-Up> <Esc>v<Up>
imap <S-Down> <Esc>v<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>

" copy paste like gui
vmap <C-c> "+y<Esc>i
vmap <C-x> "+d<Esc>i
imap <C-v> "+pi
imap <C-v> <Esc>"+pi
imap <C-z> <Esc>ui
inoremap <C-a> <Esc>ggVG
vnoremap <C-a> <Esc>ggVG
xnoremap <C-a> <Esc>ggVG
tnoremap <C-a> <Esc>ggVG
xnoremap p pgv"@=v:register.'y'<CR>

" copy default reg to/from system/mouse clipboard
noremap <Leader>y :let @+=@"<CR>
nnoremap <Leader>p :let @"=@+<CR>
noremap <Leader>Y :let @*=@"<CR>
nnoremap <Leader>P :let @"=@*<CR>

" do not yank on replace or delete
vnoremap <Leader>p "_dp
xnoremap <Leader>p "_dp
vnoremap <Leader>P "_dP
xnoremap <Leader>P "_dP
noremap <leader>d "_d
noremap <leader>d "_d
noremap <leader>x "_x
noremap <leader>x "_x


" move between windows
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-h> <c-w>h
nnoremap <C-l> <c-w>l 

" escape terminal and move to window
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-l> <c-\><c-n><c-w>l 

" open terminal window below
nnoremap th :belowright terminal<CR><C-\><C-n>:ownsyntax off<CR>:exe 'resize' . (winheight(0) * 1/2)<CR>i

" Enable spell checking
set spell spelllang=en_us,ru

" Commands and functions
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
	\ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
	\ |   exe "normal! g`\""
	\ | endif

" make tags with respect to .gitignore and do not follow sym links
command! MakeTags !git ls-files | ctags --links=no -L -

" add spell dictionary to auto completion
au BufNewFile,BufRead *.txt,*.md set complete+=k

" disable spell check in specific files
au BufNewFile,BufRead *.fun,*.pks,*.pkb,*.sql,*.pls,*.plsql,.*rc set nospell

" Enable plugins (comment out to turn off all plugins at once)
source ~/.vim/plugins.vim
