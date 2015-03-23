" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


"g:my_vim_dir is used elsewhere in my vim configurations
let g:my_vim_dir=expand("$HOME/.vim")

"$HOME/.vim and $HOME/.vim/after are in the &rtp on unix
"But on windows, they need to be added.
if has("win16") || has("win32") || has("win64")
  "add g:my_vim_dir to the front of the runtimepath
   execute "set rtp^=".g:my_vim_dir
   silent! set guifont=Source_Code_Pro:h11:cANSI
  "add g:my_vim_dir\after to the end of the runtimepath
  execute "set rtp+=".g:my_vim_dir."\\after"
  "Note, pathogen#infect() looks for the 'bundle' folder in each path
  "of the &rtp, where the last dir in the '&rtp path' is not 'after'. The
  "<path>\bundle\*\after folders will be added if and only if
  "the corresponding <path>\after folder is in the &rtp before
  "pathogen#infect() is called.  So it is very important to add the above
  "'after' folder.
  "(This applies to vim plugins such as snipmate, tabularize, etc.. that
  " are loaded by pathogen (and perhaps vundle too.))

  " Not necessary, but I like to cleanup &rtp to use \ instead of /
  " when on windows machines
  let &rtp=substitute(&rtp,"[/]","\\","g")

  "On windows, if called from cygwin or msys, the shell needs to be changed
  "to cmd.exe to work with certain plugins that expect cmd.exe on windows versions
  "of vim.
  if &shell=~#'bash$'
    set shell=$COMSPEC " sets shell to correct path for cmd.exe
  endif
endif

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
"imap <C-h> <nop>
"imap <down> <nop>
"imap <left> <nop>
"imap <right> <nop>

imap jk <Esc>

"format paragraph emacs style
map <A-q> gqap
imap <A-q> gqap

"insert newline by hitting enter
map <C-CR> o<Esc>k

execute pathogen#infect()

" TODO: this may not be in the correct place. It is intended to allow overriding <Leader>.
" source ~/.vimrc.before if it exists.
if filereadable(expand("~/.vimrc.before"))
  source ~/.vimrc.before
  endif

  " ================ General Config ====================

  set number "Line numbers are good
  set backspace=indent,eol,start "Allow backspace in insert mode
  set history=1000 "Store lots of :cmdline history
  set showcmd "Show incomplete cmds down the bottom
  set showmode "Show current mode down the bottom
  set gcr=a:blinkon0 "Disable cursor blink
  set visualbell "No sounds
  set autoread "Reload files changed outside vim
  set incsearch
  set ignorecase
  set smartcase
  set ruler
  nmap \q :nohlsearch<CR>

  autocmd BufWritePre * :%s/\s\+$//e "strip trailing white space for all files

  if $TERM == "xterm-color" || $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
    set t_Co=256
  endif

  " ================= Ctrl-P=============================
  :nmap ; :CtrlPBuffer<CR>
  :let g:ctrlp_map = '<Leader>t'
  ":let g:ctrlp_match_window_bottom = 0
  :let g:ctrlp_match_window_reversed = 0
  :let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
  :let g:ctrlp_working_path_mode = 0
  :let g:ctrlp_dotfiles = 0
  :let g:ctrlp_switch_buffer = 0

  " This makes vim act like all other editors, buffers can
  " exist in the background without being in a window.
  " http://items.sjbach.com/319/configuring-vim-right
  set hidden

  "turn on syntax highlighting
  syntax on
  set background=dark
  colorscheme solarized

  "Cursort Color
  au InsertLeave * hi Cursor guibg=red
  au InsertEnter * hi Cursor guibg=green


  " Window navigation
  map <c-j> <c-w>j
  map <c-k> <c-w>k
  map <c-l> <c-w>l
  map <c-h> <c-w>h

  "change current working directory when entering a buffer
  "autocmd BufEnter * silent! lcd %:p:h

  " Change leader to a comma because the backslash is too far away
  " That means all \x commands turn into ,x
  " The mapleader has to be set before vundle starts loading all
  " the plugins.
  let mapleader=","

  " =============== Vundle Initialization ===============
  " This loads all the plugins specified in ~/.vim/vundle.vim
  " Use Vundle plugin to manage all other plugins
  if filereadable(expand("~/.vim/vundles.vim"))
    source ~/.vim/vundles.vim
    endif

    " ================ Search Settings =================

    set incsearch "Find the next match as we type the search
    set hlsearch "Hilight searches by default
    set viminfo='100,f1 "Save up to 100 marks, enable capital marks

    " ================ Turn Off Swap Files ==============

    set noswapfile
    set nobackup
    set nowb

    " ================ Persistent Undo ==================
    " Keep undo history across sessions, by storing in file.
    " Only works all the time.

    silent !mkdir ~/.vim/backups > /dev/null 2>&1
    set undodir=~/.vim/backups
    set undofile

    " ================ Indentation ======================

    filetype plugin indent on
    set autoindent
    set cindent
    set smarttab
    set shiftwidth=4
    set shiftround
    set softtabstop=4
    set tabstop=4
    set expandtab
    set smarttab
    set cinoptions+=(s

    " Display tabs and trailing spaces visually
    set list listchars=tab:\ \ ,trail:.

    set nowrap "Don't wrap lines
    set linebreak "Wrap lines at convenient points

    " ================ Folds ============================

    set foldmethod=indent "fold based on indent
    set foldnestmax=3 "deepest fold is 3 levels
    set nofoldenable "dont fold by default

    " ================ Completion =======================

    set wildmode=list:longest
    set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
    set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
    set wildignore+=*vim/backups*
    set wildignore+=*sass-cache*
    set wildignore+=*DS_Store*
    set wildignore+=vendor/rails/**
    set wildignore+=vendor/cache/**
    set wildignore+=*.gem
    set wildignore+=log/**
    set wildignore+=tmp/**
    set wildignore+=*.png,*.jpg,*.gif

    "

    " ================ Scrolling ========================

    set scrolloff=8 "Start scrolling when we're 8 lines away from margins
    set sidescrolloff=15
    set sidescroll=1


    "Python -----------------------------------------------------
    au FileType python set omnifunc=pythoncomplete#Complete
    let g:SuperTabDefaultCompletionType = "context"
    let g:flake8_max_line_length=160
    let g:flake8_ignore="E126, E226"
    "autocmd BufWritePost *.py call Flake8()

    let g:jedi#use_tabs_not_buffers = 0
    map <leader>j :RopeGotoDefinition<CR>
    map <leader>r :RopeRename<CR>


   " Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    if sys.platform.startswith("win"):
        activate_this = os.path.join(project_base_dir, 'Scripts/activate_this.py')
    else:
        activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

    " =============== Markdown ==========================
    au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,*.md  setf markdown
    " =============== HTML ==============================
    au BufRead *.html,<&faf;HTML>  runtime! syntax/html.vim

    au BufNewFile,BufRead *.mortran,*.macros setf syntax=fortran
