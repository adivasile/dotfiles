filetype off
set shada="NONE"
set runtimepath+=~/.dotfiles/vim
set path+=my_client

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-rails'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-dispatch'
Plug 'itchyny/lightline.vim'
Plug 'mbbill/undotree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'chrisbra/Colorizer'
Plug 'tpope/vim-rhubarb'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mtth/scratch.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
Plug 'universal-ctags/ctags'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'
Plug 'neomake/neomake'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "
let g:mapleader = " "

call neomake#configure#automake('nrwi', 500)
let g:neomake_ruby_enabled_makers = ['rubocop']
let g:neomake_open_list=0
autocmd! BufWritePost * Neomake
autocmd FileType ruby nnoremap <buffer> <leader>lc :!rubocop -a %<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Harpoon
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

lua << EOF
require("harpoon").setup({
    global_settings = {
        save_on_toggle = true,
        save_on_change = true,
        enter_on_sendcmd = false,
    }
})
EOF

nnoremap <leader>ha :lua require("harpoon.mark").add_file()<CR>
nnoremap <leader>hs :lua require("harpoon.ui").toggle_quick_menu()<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocursorcolumn
set nocursorline
" syntax sync minlines=256
set synmaxcol=120

set nocompatible
" Sets how many lines of history VIM has to remember
set history=9999

set foldmethod=indent
set foldnestmax=3
set nofoldenable

autocmd VimResized * wincmd =

" Enable filetype plugin
filetype plugin indent on

" Set to auto read when a file is changed from the outside
set autoread
set number

" Fast editing of the .vimrc
map <leader>n :e! ~/.nvimrc<cr>
" Enable colors
nmap <leader>co :ColorHighlight<CR>

nmap <leader>cp :let @+=@%<CR>
nmap <leader>cf :let @+=expand("%:t:r")<CR>

nnoremap gw :grep <cword> . <cr>
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" When vimrc is edited, reload it
autocmd! BufWritePost ~/.nvimrc source ~/.config/nvim/init.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 4 lines to the curors - when moving vertical..
set so=4
set synmaxcol=0

set wildmenu "Turn on WiLd menu
set wildmode=longest,list
set scrolloff=3

set cmdheight=1 "The commandbar height

set hidden "Change buffer - without saving

set wrap
" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase

set showmatch "Show matching bracets when text indicator is over them
set mat=2 "How many tenths of a second to blink

" No sound on errors
set noerrorbells
set novisualbell
set tm=500

set lazyredraw

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

" Set font according to system

set shell=/bin/zsh

set background=dark

let g:solarized_termtrans = 1
let g:solarized_termcolors=256
let g:dracula_colorterm = 0
colorscheme dracula

hi clear SignColumn
" highlight Pmenu ctermbg=gray guibg=gray

" set encoding=utf8
try
    lang en_US
catch
endtry

set ffs=unix,dos,mac "Default file types

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Undotree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>u :UndotreeToggle<CR>
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_WindowLayout = 1
let g:undotree_DiffpanelHeight = 15
let g:undotree_SplitWidth = 40


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ripgrep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
" command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --fixed-strings --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
nnoremap <leader>F :Rg<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile

"Persistent undo
set undodir=~/.vim_tmp/undodir
set undofile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set smarttab

set lbr
set tw=500

set ai "Auto indent
set si "Smart indet

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers
map <silent> <cr> :noh<cr>
nnoremap n nzz
nnoremap N Nzz
nnoremap J mzJ`z


" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Use the arrows for something usefull
map <right> <nop>
map <left> <nop>
map <up> <nop>
map <down> <nop>

" move to beginning/end of line
noremap B ^
noremap E $<left>

" $/^ doesn't do anything
noremap $ <nop>
noremap ^ <nop>
nnoremap gV `[v`]

" Saving

nmap <leader>w :w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

inoremap nn <ESC>


"""""""""""""""""""""""""""""""
"" => Scratch
"""""""""""""""""""""""""""""""
let g:scratch_height = 80
let g:scratch_persistence_file = '.scratch.vim'
let g:scratch_insert_autohide = 0
let g:scratch_horizontal = 0
nnoremap gp :ScratchPreview<CR>


"""""""""""""""""""""""""""""""
"" => NERDTree
"""""""""""""""""""""""""""""""

nnoremap <tab><tab> :NERDTreeToggle<cr>
let g:NERDTreeWinSize=50
nmap <leader>tf :NERDTreeFind<CR>zz

"""""""""""""""""""""""""""""""
"" => Statusline
"""""""""""""""""""""""""""""""

let g:lightline = {
  \   'colorscheme': 'dracula',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \   'fileformat': 'LightlineFileformat',
  \   'fileencoding': 'NoEncoding',
  \   'filetype': 'LightlineFiletype',
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}

let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }

function! LightlineFileformat()
  return ''
endfunction

function! NoEncoding()
  return ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

set guioptions-=e  " Don't use GUI tabline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>f :GFiles<CR>
nmap <leader>b :Buffers<CR>
let g:fzf_layout = { 'down': '10split enew' }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILE NAVIGATION STUFF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildignore+=*.o,*.obj,.git,*.pyc

map <leader>y "+y
map <leader>p "+p

map <leader>v :vs<cr>
map <leader>s :sp<cr>
map <leader>x :q<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rails
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>r :w<CR>:Rails<CR>
nmap <leader>R :w<CR>:.Rails<CR>
map <leader>rg :topleft 100 :split Gemfile<cr>
map <leader>rr :topleft :split config/routes.rb<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SURROUND
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <leader>sp ysiw)
map <leader>s' ysiw'
map <leader>s` ysiw`
map <leader>c' cs"'

cnoremap dox exec '!chmod +x ' . @%  <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>g :Git 
nnoremap <leader>gb :Git blame<CR> 
nnoremap <leader>gs :Git<CR> 
nnoremap <leader>gr :Gread<CR> 
nnoremap <leader>gcd :Git checkout development<CR> 
nnoremap <leader>gcm :Git checkout master<CR> 
nnoremap <leader>gc :Git checkout 
nnoremap <leader>gcb :Git checkout -b 
nnoremap <leader>gco :Git commit -m ""<left>
nnoremap <leader>grc :Git reset HEAD~1 --soft<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup cmds
  autocmd! cmds
  au Filetype javascript nnoremap <leader>d Odebugger<esc>==
  au Filetype typescript nnoremap <leader>d Odebugger<esc>==
  au Filetype coffee nnoremap <leader>d Odebugger<esc>==
  au Filetype ruby nnoremap <leader>d Obyebug<esc>==
augroup END

