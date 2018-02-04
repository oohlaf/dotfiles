" General settings

set ruler               " Display cursor position, default on Debian.
set number              " Display line numbers
set showcmd             " Show partial command in status line.
set showmatch           " Show matching brackets.

set hlsearch            " Highlight search strings.
set incsearch           " Continue searching.
set ignorecase          " Do case insensitive matching.

set nojoinspaces        " Don't insert two spaces after punctuation characters when realigning

set nowrap
set lcs=extends:>,precedes:<    " Show > and < characters on long lines.
set scrolloff=10                " Try to keep 10 lines above and below cursor.
set sidescroll=5                " Scroll per 5 columns when scrolling sideways.

set textwidth=78
set backspace=indent,eol,start

set grepprg=grep\ -nH\ $*

set foldmethod=marker   " Fold on {{{ and }}} markers in comments.

set nobackup
"set backupdir=~/tmp/vim

set title               " Set xterm title.
set ttymouse=xterm2     " Enable xterm mouse support.

set timeoutlen=2000     " Give mappings a slight longer delay, default is 1000.
set ttimeoutlen=500

" File encodings: try unicode first.
if has("multi_byte")
    set encoding=utf-8
    setglobal fileencoding=utf-8
endif
set fileencodings=utf-8,iso-8859-15

set laststatus=2        " Always show status bar in terminal.
set showtabline=2       " Always show tab bar in terminal.

" Enable syntax highlighting if it's supported.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
    syntax on
else
    syntax off
endif

" Ignore python compiled files
let NERDTreeIgnore=['\.pyc$']
" NERD tree on the right
let NERDTreeWinPos='right'
" Taglist on the left
let Tlist_Use_Right_Window=0
" Move cursor to taglist
let Tlist_GainFocus_On_ToggleOpen=1
" Don't allow taglist to increase window width
let Tlist_Inc_Winwidth=0

" Auto commands {{{

if has("autocmd")
    filetype plugin on  " Default on debian.
    filetype indent on

    autocmd! BufRead,BufNewFile *.cls,*dtx set filetype=tex

    autocmd! BufRead,BufNewFile *.dsl set filetype=asl

    autocmd! BufNewFile,BufRead *.ldg,*.ledger set filetype=ledger
    
    autocmd! BufRead,BufNewFile *.zcml set filetype=zcml
    
    autocmd! BufRead,BufNewFile *.jsonld set filetype=json
    autocmd! BufRead,BufNewFile *.hbs,*.handlebars set filetype=handlebars syntax=html

    autocmd FileType contex set wrap
    autocmd FileType contex set linebreak       " Don't break in the middle of words
    autocmd FileType contex set showbreak=>\    " Prepend '>> ' on broken lines
    autocmd FileType contex set textwidth=0
    autocmd FileType contex set softtabstop=2
    autocmd FileType contex set shiftwidth=2
    autocmd FileType contex set smarttab
    autocmd FileType contex set expandtab
    autocmd FileType contex set autoindent

    "autocmd FileType tex map <up> g<up>
    "autocmd FileType tex map <down> g<down>
    "autocmd FileType tex map <home> g<home>
    "autocmd FileType tex map <end> g$
    "autocmd FileType tex imap <up> <C-o>g<up>
    "autocmd FileType tex imap <down> <C-o>g<down>
    "autocmd FileType tex imap <home> <C-o>g<home>
    "autocmd FileType tex imap <end> <C-o>g<end>
    " Make pdflatex the default rule for latex-suite.
    autocmd FileType tex let g:Tex_DefaultTargetFormat='pdf'
    " To cycle with <C-n> within labels like \label{fig:foo}.
    autocmd FileType tex set iskeyword+=:
    
    autocmd FileType mp set softtabstop=2
    autocmd FileType mp set shiftwidth=2

    " Text width of 72 is standard for mail.
    autocmd FileType mail set textwidth=72

    " For svn-commit, don't create backups and set text width to 72.
    autocmd BufRead svn-commit.tmp setlocal nobackup
    autocmd BufRead svn-commit.tmp set textwidth=72

    " For bzr-commit, don't create backups and set text width to 72.
    autocmd BufRead bzr_log.* setlocal nobackup
    autocmd BufRead bzr_log.* set textwidth=72

    " ACPI Source Language
    autocmd FileType asl set shiftwidth=4
    autocmd FileType asl set textwidth=80
    autocmd FileType asl set expandtab
    autocmd FileType asl set smarttab
    
    " ZCML
    autocmd FileType zcml set shiftwidth=2
    autocmd FileType zcml set softtabstop=4
    autocmd FileType zcml set expandtab

    autocmd FileType c,cpp set shiftwidth=4
    autocmd FileType c,cpp set tabstop=4
    autocmd FileType c,cpp set noexpandtab
    autocmd FileType c,cpp set autoindent

    " Python PEP8
    autocmd FileType python set textwidth=79
    autocmd FileType python set softtabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd FileType python set expandtab
    autocmd FileType python set smarttab
    autocmd FileType python set autoindent

    " PHP
    autocmd FileType php set textwidth=79
    autocmd FileType php set tabstop=8
    autocmd FileType php set softtabstop=8
    autocmd FileType php set shiftwidth=8
    autocmd FileType php set noexpandtab
    autocmd FileType php set smarttab
    autocmd FileType php set autoindent

    " SQL
    autocmd FileType sql set softtabstop=4
    autocmd FileType sql set shiftwidth=4
    autocmd FileType sql set smarttab
    autocmd FileType sql set expandtab
    autocmd FileType sql set autoindent

    " Lisp
    autocmd FileType lisp set softtabstop=2
    autocmd FileType lisp set shiftwidth=2
    autocmd FileType lisp set expandtab
    autocmd FileType lisp set smarttab
    autocmd FileType lisp set autoindent
    
    " Handlebars
    autocmd FileType handlebars set textwidth=0
    autocmd FileType handlebars set softtabstop=4
    autocmd FileType handlebars set shiftwidth=4
    autocmd FileType handlebars set expandtab
    autocmd FileType handlebars set smarttab
    autocmd FileType handlebars set autoindent
    
    " Javascript
    autocmd FileType javascript set textwidth=79
    autocmd FileType javascript set softtabstop=4
    autocmd FileType javascript set shiftwidth=4
    autocmd FileType javascript set expandtab
    autocmd FileType javascript set smarttab
    autocmd FileType javascript set autoindent
    
    " JSON-LD
    autocmd FileType json set textwidth=79
    autocmd FileType json set softtabstop=4
    autocmd FileType json set shiftwidth=4
    autocmd FileType json set expandtab
    autocmd FileType json set smarttab
    autocmd FileType json set autoindent
    
    " HTML
    autocmd FileType html set textwidth=79
    autocmd FileType html set softtabstop=4
    autocmd FileType html set shiftwidth=4
    autocmd FileType html set expandtab
    autocmd FileType html set smarttab
    autocmd FileType html set autoindent
    
    " CSS
    autocmd FileType css set textwidth=79
    autocmd FileType css set softtabstop=4
    autocmd FileType css set shiftwidth=4
    autocmd FileType css set expandtab
    autocmd FileType css set smarttab
    autocmd FileType css set autoindent

    " YAML
    autocmd FileType yaml set softtabstop=2
    autocmd FileType yaml set shiftwidth=2
    autocmd FileType yaml set expandtab
    autocmd FileType yaml set smarttab
    autocmd FileType yaml set autoindent
endif

" }}}
