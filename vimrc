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
if exists(':runtime') && filereadable(expand('$VIMRUNTIME/defaults.vim'))
    runtime! defaults.vim
endif

" Use Vim settings, rather than Vi settings (much better!). This must be first,
" because it changes other options as a side effect. Avoid side effects when it
" was already reset.
if &compatible
  set nocompatible
endif

" If you have Hack Nerd Font installed on you system set has_nerd_font to true.
" This will add symbols and icons to the statusline, listchars, and fillchars.
let has_nerd_font = v:true

" Set the character encoding used inside of Vim.
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Switch syntax highlighting on when the terminal has colors or when using the
" GUI (which always has colors).
if &t_Co > 2 || has("gui_running")
  " Revert with ":syntax off".
  syntax on
  " Set the colorscheme
  colorscheme habamax
  " I like highlighting strings inside C comments.
  let c_comment_strings=1
endif

" If not running in a gui, use at least 256 colors.
if !has("gui_running")
  " Check if terminal supports 256 colors
  if &term == 'win32' || &term == 'ansi'
    if &t_Co < 256
      set t_Co=256
    endif
    " Enable true color support if available
    if has("termguicolors")
      set termguicolors
    endif
  endif
endif

" Use the system clipboard if available. This option is a list of
" comma-seperated names. Do not use += or -= for this option. Some of the
" Possible options: unnamed, unnamedplus, autoselect, autoselectplus, html
if has('clipboard')
  set clipboard^=autoselectplus
endif

" In many terminal emulators the mouse works just fine. By enabling it you can
" position the cursor, Visually select and scroll with the mouse. Only xterm
" can grab the mouse events when using the shift key, for other terminals
" use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Use visual error bells, instead of audible. To turn off visual use:
" set t_vt=
set visualbell

" automatically sets options from from the modeline (" vim: ts=2 sw=2 et)
set modeline

" Use a dialog when an operation has to be confirmed.
" confirm can take args: q, aq, w (set confirm q)
set confirm

" When off a buffer is unloaded when it is abandoned. When on a buffer
" becomes hidden when it is abandoned.
set hidden

set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands

set showmatch         " automatically show matching brackets

set ttimeout          " time out for key codes
set ttimeoutlen=100   " wait up to 100ms after Esc for special key

set number            " show line numbers

set path=.,./.,**     " expand the path of the find command

" Show the line number relative to the line with the cursor in front of
" each line. Relative line numbers help you use the count you can
" precede some vertical motion commands.
set relativenumber

" Set default tab spacing and indentation
set tabstop=4       " defines the column multiple used to display a Tab
set softtabstop=4   " soft tabs are used in Insert mode instead of Tabs
set shiftwidth=4    " number of spaced that make up an anto-indent
set expandtab       " use spaces instead of tabs
set autoindent      " copy indent from current line
set smartindent     " like cindent, only better in most cases

" Search setting
set ignorecase      " ignore case in search patterns
set smartcase       " override 'ignorecase' if capital letters are used

" if Vim has color support, switch on highlighting for search patterns.
if &t_Co > 2 || has("gui_running")
  set hlsearch
endif

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=10

" When on, splitting a window will put the new window right of the
" current one. :vsplit
set splitright

" When on, splitting a window will put the new window below the current
" one. :split
set splitbelow

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" When on, lines longer than the width of the window will wrap and displaying
" continues on the next line.
set wrap

" Maximum width of text that is being inserted.
set textwidth=80

" This is a sequence of letters which describes how automatic formatting is to
" be done. See ":help fo-table" for additional options.
set formatoptions+=t

" A comma-separated list of screen columns that are highlighted with
" ColorColumn. Useful to aligh text. Can make screen redrawing slower.
" Will only work if compiled with syntax.
if has('syntax')
  " set the first column width, I personally like 80
  set colorcolumn=80
  highlight ColorColumn ctermbg=DarkGrey guibg=antiquewhite4
endif

" Changes the way text is displayed. This can be a comma-separated list of
" flags: lastline, truncate, uhex
set display=lastline

" By default when 'display=truncate', @@@ will be displayed in the first
" line to indicate that the text has been truncated. These characters can
" be changed with 'fillchars'.
if has_nerd_font
  set fillchars+=vert:│,trunc:,foldopen:,foldclose:,lastline:↲
else
  set fillchars+=vert:│,trunc:>,lastline:@
endif

" Useful to see the difference between tabs and spaces and for trailing blanks.
" Further changed by the 'listchars option.
set list

" Strings to use in 'list' mode and for the :list command. It is a
" comma-separated list of string settings.
if has_nerd_font
  set listchars=tab:»·,trail:·,extends:,precedes:,nbsp:␣
else
  set listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:_
endif

if has('statusline')
  " The value of this option influences when the last window will have a
  " statusline: 0 -> never, 1 -> only when two windows, 2 -> always
  set laststatus=2

  " Setup custom statusline. See :help 'statusline' for more details.
  " Nerd font will provide support for better symbols.
  if has_nerd_font
    set statusline=%#StatusLine#%<\ \ %f\ %h%w%m%r\ %=%#StatusLineNC#\
      \%l\ ☰\ %c\ ⮞\ %V\ │\ %P
  else
    set statusline=%<%f\ %h%w%m%r%=%-14.(%l,%c%V%)\ %P
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
"                      Eval Features And Native Plugins:                      "
"============================================================================="
" Only do this part when Vim was compiled with the +eval feature.
if has('eval')
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent
  " Revert with ":filetype off".
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

  " Setup Netrw (Ntree/Explore) if available
  if exists("g:did_load_filetypes")
    packadd! netrw
    let g:netrw_banner = 0      " turn off the banner
    let g:netrw_liststyle = 3   " tree tyle listing
    let g:netrw_preview = 2     " open preview in vsplit
    let g:netrw_winsize = 25    " set the width of Lexplore
  endif

  " A simple function to remove trailing whitespace
  function! ClearTrailingWhitespace()
    " save the cursor position
    let l:cursor = getpos('.')
    " remove the whitespace
    silent! %s/\s\+$//e
    " restore the cursor position
    call setpos('.', l:cursor)
  endfunction

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
    " Don't do it when the position is invalid, when inside an event
    " handler (happens when dropping a file on gvim), for a commit or
    " rebase message (likely a different one than last time), and when
    " using xxd(1) to filter and edit binary files (it transforms input
    " files back and forth, causing them to have dual nature, so to speak)
    " or when running the new tutor
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \      && !&diff
      \ |   execute "normal! g`\""
      \ | endif

    " Set the default background for putty to dark. Putty usually sets the
    " $TERM to xterm and by default it starts with a dark background which
    " makes syntax highlighting often hard to read with bg=light
    " undo this using:  ":au! vimStartup TermResponse"
    autocmd TermResponse *
          \ if v:termresponse == "\e[>0;136;0c" | set bg=dark | endif
  augroup END

  " Quite a few people accidentally type "q:" instead of ":q" and get
  " confused by the command line window.  Give a hint about how to get
  " out. If you don't like this you can put this in your vimrc:
  " ":autocmd! vimHints"
  augroup vimHints
    au!
    autocmd CmdwinEnter *
	  \ echohl Todo |
	  \ echo gettext('Command-Line Window: Use :q to close') |
	  \ echohl None
  augroup END
  " Convenient command to see the difference between the current buffer
  " and the file it was loaded from, thus the changes you made.
  " Only define it when not defined already.
  " Revert with: ":delcommand DiffOrig".
  if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
  		  \ | wincmd p | diffthis
  endif

  if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result
    " from a mapping.
    set nolangremap
  endif

  " Use the internal diff if available.
  " Otherwise use the special 'diffexpr' for Windows.
  if &diffopt !~# 'internal'
    set diffexpr=MyDiff()
  endif
  function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg1 = substitute(arg1, '!', '\!', 'g')
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg2 = substitute(arg2, '!', '\!', 'g')
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let arg3 = substitute(arg3, '!', '\!', 'g')
    if $VIMRUNTIME =~ ' '
      if &sh =~ '\<cmd'
        if empty(&shellxquote)
          let l:shxq_sav = ''
          set shellxquote&
        endif
        let cmd = '"' . $VIMRUNTIME . '\diff"'
      else
        let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
      endif
    else
      let cmd = $VIMRUNTIME . '\diff'
    endif
    let cmd = substitute(cmd, '!', '\!', 'g')
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
    if exists('l:shxq_sav')
      let &shellxquote=l:shxq_sav
    endif
  endfunction

  " Unix Specific Options
  if has('unix')
    " Create directories for swap, backup, and undo files if they do not
    " exist. This will prevent '~' and '.' files from littering your
    " directories.
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
      set backup    " keep a backup file (restore to previous version)
      set backupdir=~\.vim\tmp\\
      set undofile  " keep an undo file (undo changes after closing)
      set undodir=~\.vim\tmp\\
    else
      set nobackup
      set noundofile
    endif
  endif

  " Windows Specific Options
  if has('win32')
    " Remove 't' flag from 'guioptions': no tearoff menu entries.
    set guioptions-=t
    set guioptions+=!

    " Create directories for swap, backup, and undo files if they do not
    " exist. This will prevent '~' and '.' files from littering your
    " directories.
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
      set backup		" keep a backup file (restore to previous version)
      set backupdir=~\vimfiles\tmp\\
      set undofile	" keep an undo file (undo changes after closing)
      set undodir=~\vimfiles\tmp\\
    else
      set nobackup
      set noundofile
    endif
  endif

endif   " end of if 1 (compiled with +eval)

"============================================================================="
"                            Gvim GUI Options:                                "
"============================================================================="
" Gui Specific Options
if has('gui_running')
  set guioptions-=T     " Disable the toolbar
  set guioptions-=r     " Turn off right scrollbar
  set guioptions-=L     " Turn off left scrollbar
  set guioptions-=h     " Turn off horizontal scrollbar
  set guioptions+=d     " Enable dark window theme
  set guioptions+=a     " Autoselect clipboard
  set guioptions+=A     " autoselect plus clipboard
  set guioptions+=g     " make inactive menu items grey
  " Set Gui font is available
  if has_nerd_font
    set guifont=Hack\ Nerd\ Font\ Mono:h9.5
  endif
endif

" Specify the character encoding used in this script.
scriptencoding=utf-8

" EOF: Nothing below this line
" vim: ts=2 sw=2 et
