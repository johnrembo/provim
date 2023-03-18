" Plugin section

call plug#begin()

" import .env file
Plug 'tpope/vim-dotenv'

" import .editorconfig file
Plug 'editorconfig/editorconfig-vim'

" fast motions using f F like behavior
Plug 'easymotion/vim-easymotion'

" tag outline 'preservim/tagbar'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" hotkey helper
Plug 'liuchengxu/vim-which-key'

" enable fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" find project root
Plug 'dbakker/vim-projectroot'

" comment/uncomment blocks and selections
Plug 'preservim/nerdcommenter'

" NerdTree
Plug 'preservim/nerdtree'
" NerdTree git support
Plug 'Xuyuanp/nerdtree-git-plugin'
" VimDevIcons for NerdTree and Airline
Plug 'ryanoasis/vim-devicons'

" Database
Plug 'vim-scripts/dbext.vim'
Plug 'tpope/vim-dadbod'

" Conqueror of completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" PHP LSP
Plug 'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}

" PHP Code Sniffer
Plug 'bpearson/vim-phpcs'

" DAP manager
Plug 'puremourning/vimspector'

" more informative status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" sonokai full color scheme
Plug 'sainnhe/sonokai'

call plug#end()

" color scheme setup
let g:sonokai_style = 'default'
let g:sonokai_better_performance = 1 

let g:airline_theme='sonokai'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:sonokai_transparent_background = 1
let g:sonokai_diagnostic_text_highlight = 1 
let g:sonokai_spell_foreground = 'colored'

" color scheme with enabled plugins
colorscheme sonokai

" scheme fine tuning
hi Comment guifg=#707070 ctermfg=darkgray
hi Visual guifg=#333333 guibg=darkgray

" Plugin keymaps


" whichkey

let g:which_key_map = {}
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }
let g:which_key_map.b = { 'name' : '+buffers' }
let g:which_key_map.c = { 'name' : '+comment' }
let g:which_key_map.f = { 'name' : '+fzf' }
let g:which_key_map.t = { 'name' : '+tabs tags term' }
let g:which_key_map_visual = {}

nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

call which_key#register('<Space>', "g:which_key_map", 'n')
call which_key#register('<Space>', "g:which_key_map_visual", 'v')


" tagbar toggle
nmap <leader>tt :TagbarToggle<CR>
let g:which_key_map.t.t = 'Toggle Tagbar'

" fuzzy finder
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader>ff :Files<CR> 
nmap <leader>fg :GFiles<CR> 
nmap <leader>fb :Buffers<CR> 
nmap <leader>fc :Rg<CR> 
nmap <leader>fk :Maps<CR>
let g:which_key_map.f.f = 'FZF files'
let g:which_key_map.f.g = 'FZF Git files '
let g:which_key_map.f.b = 'FZF buffers'
let g:which_key_map.f.c = 'FZF lines'
let g:which_key_map.f.k = 'FZF keymaps'

" nerd commenter
map <leader>/ <Plug>NERDCommenterToggle
let g:which_key_map.e = 'Toggle comment'
" nerd tree toggle
nmap <leader>e :NERDTreeToggle<CR>
let g:which_key_map.e = 'NERDTree toggle'
" nerd tree show hidden by default
let NERDTreeShowHidden = 1

" Coc config
source ~/.vim/coc.vim

" Commands and functions

" change current dir to project root on open
function! <SID>AutoProjectRootCD()
    try
      if &ft != 'help'
        ProjectRootCD
      endif
    catch
      " Silently ignore invalid buffers
    endtry
endfunction
autocmd BufEnter * call <SID>AutoProjectRootCD()

let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader><F1> :CocCommand java.debug.vimspector.start<CR>
