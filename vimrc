" Vim Configuration File:                                                vimrc
" A simple configuration that works on windows or linux.
" No additional packages or software, just vim.

" Maintainer: Joshua Reese <https://github.com/reesej22>
" Last Change: 2025 June 23

" To use it, copy it to
"  for Unix:    ~/.vimrc
"  for MS-Win:  $VIM\_vimrc

"============================================================================="
"                                  Options:                                   "
"============================================================================="
" Load the defaults.vim if it is available
if filereadable(expand('$VIMRUNTIME/defaults.vim'))
  unlet! skip_defaults_vim
  runtime! defaults.vim
endif

let has_nerd_font = v:true  " enable nerd font symbols and icons

set encoding=utf-8          " default character encoding used inside vim
set termencoding=utf-8      " character encoding used for the terminal
set fileencoding=utf-8      " the character encoding used in the buffer

if &t_Co > 2                " If terminal supports color:
  syntax on                 " enable syntax highlighting
  colorscheme retrobox      " set colorscheme
  set hlsearch              " highlight search results
  let c_comment_strings=1   " highlight strings inside of comments.
endif

if has('clipboard')         " if available, use sys clipboard
  set clipboard=autoselectplus
endif

if has('mouse')
  set mouse=a               " if available, enable all mouse functionality
endif

set noerrorbells            " turn off errorbells

set vb t_vb=                " turn of visual error bells

set modeline                " auto set options with (" vim: ts=2 sw=2 et)

set confirm                 " use a dialog instead of error

set hidden                  " buffers becomes hidden when abandoned.

set showmatch               " automatically show matching brackets

set ttimeout                " time out for key codes
set ttimeoutlen=100         " wait up to 100ms after Esc for special key

set path=.,./.,**           " expand the path of the find command

set nu relativenumber       " user relative line numbers

set tabstop=4               " defines the column multiple used for a Tab
set softtabstop=4           " soft tabs are used in Insert mode over tabs
set shiftwidth=4            " number of spaced that make up an anto-indent
set expandtab               " use spaces instead of tabs
set autoindent              " copy indent from current line
set smartindent             " like cindent, only better in most cases

set ignorecase              " ignore case in search patterns
set smartcase               " override 'ignorecase' if capital letters

if has('reltime')
  set incsearch             " if available, do incremental searching
endif

set splitright              " vsplit: new window to the right
set splitbelow              " split: new window below

set nrformats-=octal        " <C-a> & <C-x> do not recognize octal numbers

set scrolloff=10            " Number of lines around the cursor

set wrap                    " break long lines of text

set textwidth=80            " max width of text

set formatoptions+=t        " automatic formatting options ":help fo-table"

if has('syntax')            " if available
  set colorcolumn=80        " set the column width, and color
  highlight ColorColumn ctermbg=DarkGrey guibg=antiquewhite4
endif

set display=lastline        " change the way text is displayed
if has_nerd_font
  set fillchars+=vert:│,trunc:,foldopen:,foldclose:,lastline:↲
else
  set fillchars+=vert:│,trunc:>,foldopen:-,foldclosed:+,lastline:@
endif

set list                    " display whitespace using characters
if has_nerd_font
  set listchars=tab:»·,trail:·,extends:,precedes:,nbsp:␣
else
  set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:_
endif

"============================================================================="
"                                 StatusLine:                                 "
"============================================================================="
if has('statusline')        " if available
  set laststatus=2          " display statusline always
  set ruler                 " show the cursor position all the time
  set showcmd               " display incomplete commands

  " Setup custom statusline. See :help 'statusline' for more details.
  if has_nerd_font
    set statusline=%#StatusLine#%<\|\ \ %f\ %h%w%m%r
    set statusline+=%=%#StatusLineNC#\ \ %l\:\%c\ 󰈙\ %P\|
  else
    set statusline=%#StatusLine#%<\|\ %f\ %h%w%m%r
    set statusline+=%=%#StatusLineNC#\ %l\:\%c\ %P\|
  endif

  " Statusline colors
  if has('gui_running')
    highlight StatusLine guibg=black guifg=blanchedalmond
    highlight StatusLineNC guibg=black guifg=darkcyan
  else
    highlight StatusLine ctermbg=DarkGrey ctermfg=Black
    highlight StatusLineNC ctermbg=DarkBlue ctermfg=Black
  endif
endif

"============================================================================="
"                               Key Bindings:                                 "
"============================================================================="
" Note:
"   uppercase           -> gU[motion] : wo*rd, gUiw, WORD
"   lowercase           -> gu[motion] : WO*RD, guiw, word
"   increment number    -> <C-a>      : cursor on #, 8<C-q> will add 8
"   decrement number    -> <C-x>      : cursor on #, <C-x> will sub 1
"
" Don't use Q for Ex mode, use it for formatting.  Except for Select mode.
" Revert with ":unmap Q".
map Q gq
sunmap Q

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
" Revert with ":iunmap <C-U>".
inoremap <C-U> <C-G>u<C-U>

" Resize splits with Ctrl + Arrow key instead of <C-w>+ or <C-w>-
nnoremap <C-Up> <Cmd>resize -4<Cr>
nnoremap <C-Down> <Cmd>resize +4<Cr>
nnoremap <C-Left> <Cmd>vertical resize -4<Cr>
nnoremap <C-Right> <Cmd>vertical resize +4<Cr>

" Move lines up or down with Alt + Arrow keys
" the move cmd is, :[range]move {address}
nmap <A-Up> <Cmd>move .-2<Cr>==
nmap <A-Down> <Cmd>move .+1<Cr>==

" Make it easy to quickly open Lexplore
nmap <leader>e <Cmd>Lexplore<Cr>

" Show the open buffers
nmap <leader>b <Cmd>buffers<Cr>
nmap <leader>bb :buffer

" Open Registers, <C-r> while in Insert mode, followed the reg id
nmap <leader>r <Cmd>registers<Cr>

" Open Jumps, <C-o> and <C-i> will cycle through the list, or you can
" use [num]<C-o> to jump, or <C-i> <Tab>
nmap <leader>j <Cmd>jumps<Cr>

" Open marks, use '{a-z} to goto mark, use m{a-zA-Z} to set mark.
" Use m' to set previous content make, can jump to it with '' or ``
map <leader>m <Cmd>marks<Cr>

" Use vimgrep to search and popluat quicklists
":vim[grep][!] /{pattern}/[g][j][f] {file} ...
" g: each line is adde only once,
" j: without j, vim jumps to the first match
" f: fuzzy string matching is used
nmap <leader>g :vimgrep *
  "
" Quickly jump to the find command line, start typing and use <Tab> to
" complete and search quickly
nmap <leader>f :find *

" Search for commands, like the find command, use <Tab> for completions
nmap <leader>c :command *

" Search for key maps.
nmap <leader>k :map *

" Open quickfix list
nmap <leader>q <Cmd>copen<Cr>

" Populate the the quickfix list
nmap <leader>gq <Cmd>call getqflist()<Cr>

" Delete buffer with <leader>c
nmap <leader>d <Cmd>close<Cr>

" Toggle paste with the <F2> key
set pastetoggle=<F2>

"============================================================================="
"                    Builtin Plugins And Filetype Options:                    "
"============================================================================="
" Only do this part when Vim was compiled with the +eval feature.
if has('eval')
  " Enable file type detection.
  filetype plugin indent on

  " Enable omnifunc completions
  set omnifunc=syntaxcomplete#Complete

  " A list of options for Inster mode completions
  set completeopt=fuzzy,menu,menuone,popup

  " Add optional packages.
  " Allow the package manager to load all packages saved to the
  " ~/vimfiles/pack/plugins/start directory.
  packloadall!

  " The matchit plugin makes the % command work better
  " The ! means the package won't be loaded right away
  if has('syntax')
    packadd! matchit
  endif

  " If highlight search is enable this will turn it off automatically
  " when you enter Insert mode.
  if &hlsearch
    packadd! nohlsearch
  endif

  " The builtin comment package allows you to toggle comments with "gc"
  packadd! comment

  " This package allow a new visual command "_j" to justify a text block
  packadd! justify

  " hlyank will briefly highlight the affected region of the last yank
  packadd! hlyank

  " Shellmenu is a package that is great from shell scripting.
  " Try it out with :imenu Shellmenu.... or in the gui menu bar.
  packadd! shellmenu

  " add terminal debuggind support
  packadd! termdebug

  " File explorer support
  packadd! netrw

  " Setup Netrw (Ntree/Explore) if available
  if exists("g:did_load_filetypes")
    packadd! netrw
    let g:netrw_banner = 0      " turn off the banner
    let g:netrw_liststyle = 3   " tree tyle listing
    let g:netrw_preview = 2     " open preview in vsplit
    let g:netrw_winsize = 25    " set the width of Lexplore
  endif

"============================================================================="
"                                  Functions:                                 "
"============================================================================="
  " A simple function to remove trailing whitespace
  function! ClearTrailingWhitespace()
    " save the cursor position
    let l:cursor = getpos('.')
    " remove the whitespace
    silent! %s/\s\+$//e
    " restore the cursor position
    call setpos('.', l:cursor)
  endfunction

"============================================================================="
"                               Auto Commands:                                "
"============================================================================="
  " Automatically call ClearTrailing Whitespace on write buffer
  autocmd BufWritePre * call ClearTrailingWhitespace()

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78
  augroup END

  " Put these in an autocmd group, so that you can revert them with:
  " ":autocmd! vimStartup"
  augroup vimStartup
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \      && !&diff
      \ |   execute "normal! g`\""
      \ | endif

    " Set the default background for putty to dark.
    autocmd TermResponse *
          \ if v:termresponse == "\e[>0;136;0c" | set bg=dark | endif
  augroup END

"============================================================================="
"                         Configure Undo And Backup:                          "
"============================================================================="
  " Unix Specific Options
  if has('unix')
    " Create directories for swap, backup, and undo files if they do not exist
    if !isdirectory($HOME . '\.vim\tmp')
      call mkdir($HOME . '\.vim\tmp')
    endif

    " Vim creates swapfiles by default, to "set noswapfile" to disable.
    if isdirectory($HOME . '\.vim\tmp')
      set directory=~\.vim\tmp\\
    else
      set noswapfile
    endif

    " If "-persistent_undo" will not support undo file creation.
    if has('persistent_undo') && isdirectory($HOME . '\vimfiles\tmp')
      set backup            " keep a backup file (restore to previous version)
      set backupdir=~\.vim\tmp\\
      set undofile          " keep an undo file (undo changes after closing)
      set undodir=~\.vim\tmp\\
    else
      set nobackup
      set noundofile
    endif
  endif

  " Windows Specific Options
  if has('win32')
    set guioptions-=t
    set guioptions+=!

    " Create directories for swap, backup, and undo files if they do not exist
    if !isdirectory($HOME . '\vimfiles\tmp')
      call mkdir($HOME . '\vimfiles\tmp')
    endif

    " Vim creates swapfiles by default, to "set noswapfile" to disable.
    if isdirectory($HOME . '\vimfiles\tmp')
      set directory=~\vimfiles\tmp\\
    else
      set noswapfile
    endif

    " If "-persistent_undo" will not support undo file creation.
    if has('persistent_undo') && isdirectory($HOME . '\vimfiles\tmp')
      set backup            " keep a backup file (restore to previous version)
      set backupdir=~\vimfiles\tmp\\
      set undofile          " keep an undo file (undo changes after closing)
      set undodir=~\vimfiles\tmp\\
    else
      set nobackup
      set noundofile
    endif
  endif
endif " end of if 1 (compiled with +eval)

"============================================================================="
"                            Gvim GUI Options:                                "
"============================================================================="
if has('gui_running')
  set guioptions-=T         " Disable the toolbar
  set guioptions-=r         " Turn off right scrollbar
  set guioptions-=L         " Turn off left scrollbar
  set guioptions-=h         " Turn off horizontal scrollbar
  set guioptions+=d         " Enable dark window theme
  set guioptions+=a         " Autoselect clipboard
  set guioptions+=A         " autoselect plus clipboard
  set guioptions+=g         " make inactive menu items grey
  if has_nerd_font          " use nerd font if available
    set guifont=Hack\ Nerd\ Font\ Mono:h12
  endif
endif

scriptencoding=utf-8        " specify character encoding for this script

" EOF: Nothing below this line
" vim: ts=2 sw=2 et
