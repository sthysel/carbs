" sthysel's .vimrc
" Maintained by sthysel@gmail.com
"
"" To start vim without using this .vimrc file, use:
"     vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"     vim -u NONE
"
" This vimrc is both good and original - the original bits are not good
" and the good bits are not original.
" By and large a curated version of this:
" https://raw.githubusercontent.com/nvie/vimrc/master/vimrc

" I don't care about vi, this must be first
set nocompatible
filetype off

" Vundle plugin manager
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc("~/.config/nvim/bundle/")
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
" Plugin 'scrooloose/syntastic'
Plugin 'wincent/command-t'
" orgmode
Plugin 'jceb/vim-orgmode'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-sensible'
Plugin 'airblade/vim-gitgutter'
Plugin 'ekalinin/Dockerfile.vim'
" Plugin 'majutsushi/tagbar'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
" ag-silversurfer
Plugin 'rking/ag.vim'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'davidhalter/jedi-vim'
Plugin 'Chiel92/vim-autoformat'
Plugin 'pangloss/vim-javascript'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'einars/js-beautify'
Plugin 'rstacruz/sparkup'
Plugin 'vim-scripts/closetag.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tmhedberg/SimpylFold'
Plugin 'chrisbra/csv.vim'
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-line'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sickill/vim-monokai'
call vundle#end()

filetype plugin indent on

autocmd! BufWritePost .vimrc source %

colorscheme Monokai

" here be all the leader keys
" space for mapleader
let mapleader=' '
nnoremap <leader>w :w<CR>
" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>
" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" grep/Ack/Ag for the word under cursor
vnoremap <leader>a y:grep! "\b<c-r>"\b"<cr>:cw<cr>
nnoremap <leader>a :grep! "\b<c-r><c-w>\b"
nnoremap K *N:grep! "\b<c-r><c-w>\b"<cr>:cw<cr>

" Creating folds for tags in HTML
nnoremap <leader>ft Vatzf

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <leader>m :NERDTreeClose<CR>:NERDTreeFind<CR>
nnoremap <leader>N :NERDTreeClose<CR>

noremap  <leader>g :GitGutterToggle<CR>

" edit vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
" load the vimrc file
nmap <silent> <leader>sv :source $MYVIMRC<CR>

" buffers
" nmap <leader>T :enew<CR>           " To open a new empty buffer
" nmap <leader>l :bnext<CR>          " Move to the next buffer
" nmap <leader>h :bprevious<CR>      " Move to the previous buffer
" nmap <leader>bq :bp <BAR> bd #<CR> " Close the current buffer and move to the previous one
" nmap <leader>bl :ls<CR>            " Show all open buffers and their status

" buffergator setup
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1
" Looper buffers
"let g:buffergator_mru_cycle_loop = 1
" Go to the previous buffer open
nmap <leader>jj :BuffergatorMruCyclePrev<cr>
" Go to the next buffer open
nmap <leader>kk :BuffergatorMruCycleNext<cr>
" View the entire list of buffers open
nmap <leader>bl :BuffergatorOpen<cr>

" Shared bindings from Solution #1 from earlier
nmap <leader>T :enew<cr>
nmap <leader>bq :bp <BAR> bd #<cr>


" Use :help 'option' to see the documentation for the given option.
" Editing behaviour
set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set ignorecase                  " ignore case when searching
set smartcase                   " ignore case if search pattern is all lowercase,
                                " case-sensitive otherwise
set smarttab                    " insert tabs on the start of a line according to
                                " shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set gdefault                    " search/replace "globally" (on a line) by default
set listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
set nolist                      " don't show invisible characters by default,
                                " but it is enabled for some file types (see later)
set pastetoggle=<F2>            " when in insert mode, press <F2> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
set mouse=a                     " enable using the mouse if terminal emulator
                                "    supports it (xterm does)
set fileformats="unix,dos,mac"
set formatoptions+=1            " When wrapping paragraphs, don't end lines
                                "    with 1-letter words (looks stupid)

set nrformats=                  " make <C-a> and <C-x> play well with
                                "    zero-padded numbers (i.e. don't consider
                                "    them octal or hex)
" set nrformats-=octal

set shortmess+=I                " hide the launch screen
set clipboard=unnamed           " normal OS clipboard interaction
set autoread                    " automatically reload files changed outside of Vim

" use python/perl regex, not vim build-in
nnoremap / /\v
vnoremap / /\v


" Editing behaviour ---------------------------
" Folding rules
set foldenable                  " enable folding
set foldcolumn=2                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
function! MyFoldText()
    let line=getline(v:foldstart)

    let nucolwidth=&fdc + &number * &numberwidth
    let windowwidth=winwidth(0) - nucolwidth - 3
    let foldedlinecount=v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab=strpart('          ', 0, &tabstop)
    let line=substitute(line, '\t', onetab, 'g')

    let line=strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount=windowwidth - len(line) - len(foldedlinecount) - 4
    return line . ' …' . repeat(" ",fillcharcount) . foldedlinecount . ' '
endfunction
set foldtext=MyFoldText()

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>

" Vim behaviour
set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set undofile                " keep a persistent backup file
set undodir=~/.vim/.undo,~/tmp,/tmp
set nobackup                    " do not keep backup files, it's 70's style cluttering
set directory=~/.vim/.tmp,~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:full          " show a list when pressing tab and complete
                                "    first full match
set title                       " change the terminal's title
set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)
set ttyfast                     " always use a fast terminal
set cursorline                  " underline the current line, for quick orientation

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" non patronising positive enforcement
nnoremap <Left> :echoe "No sunshine, use h"<CR>
nnoremap <Right> :echoe "*head pat* no cutie, use l"<CR>
nnoremap <Up> :echoe "Use k noob"<CR>
nnoremap <Down> :echoe "Bitch please, just use j"<CR>

set complete-=i
set completeopt=menuone,longest,preview

" mapped key sequence timeouts
set ttimeout
set ttimeoutlen=50

" always have status line on last window
set laststatus=2
set ruler
set cmdheight=2
set autoread

set encoding=utf-8
inoremap <C-U> <C-G>u<C-U>

set nobackup
set nowritebackup
set fileformats=unix,dos,mac
set viminfo='20,\"50

nmap F !}fmt^M

" exit insert mode
inoremap <C-c> <Esc>


" Plugins config
" CtrlP
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.gz,*.xz,*.bz2,protractor*.xml,karma*.xml,*.egg,*.log,*.rpm,*.deb
let g:ctrlp_custom_ignore = {'dir': '\v[\/](\.git|\.hg|\.svn|bower_components|node_modules|virt_.*|.*egg-info|data|log|biolark)'}

" Use The Silver Searcher (ag) over grep, if possible
if executable('ag')
   " Use ag over grep
   set grepprg=ag\ --nogroup\ --nocolor
   " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
   let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
   " ag is fast enough that CtrlP doesn't need to cache
   let g:ctrlp_use_caching = 0
endif

" NERDTree
" Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
" Show the bookmarks table on startup
let NERDTreeShowBookmarks=1
" Show hidden files, too
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
" Quit on opening files from the tree
let NERDTreeQuitOnOpen=1
" Highlight the selected entry in the tree
let NERDTreeHighlightCursorline=1
" Use a single click to fold/unfold directories and a double click to open
" files
let NERDTreeMouseMode=2
" Don't display these kinds of files
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '\.py\$class$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '__pycache__', '\.DS_Store' ]

" vim-airline
let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts=1
let g:Powerline_symbols='unicode'
let g:airline_theme='badwolf'

" Basic shortcuts definitions
" most in visual mode / selection (v or ⇧ v)
" indend / deindent after selecting the text with (⇧ v), (.) to repeat.
vnoremap <Tab> >
vnoremap <S-Tab> <
" comment / decomment & normal comment behavior
vmap <C-m> gc
" Disable tComment to escape some entities
let g:tcomment#replacements_xml={}
" Text wrap simpler, then type the open tag or ',"
vmap <C-w> S

set guifont=Sauce\ Code\ Powerline\ Light\ 11
" set nofoldenable

" html
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"

" indent file
map <F7> mzgg=G`z<CR>

" Explore mode
let g:netrw_liststyle=3

" pasting text into vim
set pastetoggle=<F2>


" Switch from block-cursor to vertical-line-cursor when going into/out of
" insert mode
let &t_SI="\<Esc>]50;CursorShape=1\x7"
let &t_EI="\<Esc>]50;CursorShape=0\x7"

" syntaxic n00b defaults for me
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=E501 --maxcomplexity 10"
" html tidy does not understand django templates
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" so pymode also does syntax checking and linting but I prefer syntastic
let g:pymode_lint=0

" Windows, splits
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

" Filetype specific handling
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars
        au!

        " Show invisible characters in all of these files
        autocmd filetype vim setlocal list
        autocmd filetype python,rst setlocal list
        autocmd filetype ruby setlocal list
        autocmd filetype javascript,css setlocal list
    augroup end

    augroup vim_files
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
    augroup end

    augroup html_files
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n=1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n=n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        " Auto-tidy selection
        vnoremap <leader>x :!tidy -q -i --show-errors 0 --show-body-only 1 --wrap 0<cr><cr>

        autocmd BufNewFile,BufRead *.html,*.htm,*.j2 call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        autocmd filetype html,htmldjango let b:closetag_html_style=1
        autocmd filetype html,xhtml,xml source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
    augroup end

    augroup python_files
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n=1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    set syntax=python
                    return
                endif
                let n=n + 1
            endwhile
            " go with html
            set ft=python
        endfun

        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " But disable autowrapping as it is super annoying
        " autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Automatic insertion of breakpoints
        autocmd filetype python nnoremap <buffer> <leader>bp :normal oimport pdb; pdb.set_trace()  # TODO: BREAKPOINT  # noqa<Esc>
        " Toggling True/False
        autocmd filetype python nnoremap <silent> <C-t> mmviw:s/True\\|False/\={'True':'False','False':'True'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Run a quick static syntax check every time we save a Python file
        " autocmd BufWritePost *.py call Flake8()

        " Defer to isort for sorting Python imports (instead of using Unix sort)
        autocmd filetype python nnoremap <leader>s mX:%! isort -<cr>`X
    augroup end


    augroup supervisord_files
        au!

        autocmd BufNewFile,BufRead supervisord.conf set ft=dosini
    augroup end

    augroup markdown_files
        au!

        autocmd filetype markdown noremap <buffer> <leader>p :w<CR>:!open -a Marked %<CR><CR>
    augroup end

    augroup ruby_files
        au!

    augroup end

    augroup rst_files
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end

    augroup css_files
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end

    augroup javascript_files
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=tab:▸\ ,trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}

        " Toggling True/False
        autocmd filetype javascript nnoremap <silent> <C-t> mmviw:s/true\\|false/\={'true':'false','false':'true'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Enable insertion of "debugger" statement in JS files
        autocmd filetype javascript nnoremap <leader>jdb Odebugger;<esc>
    augroup end

    augroup textile_files
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end

endif

