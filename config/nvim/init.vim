let mapleader =" "

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'preservim/nerdtree'
Plug 'PotatoesMaster/i3-vim-syntax'
call plug#end()

syntax on

set tabstop=2 shiftwidth=2 expandtab
set bg=light
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus

nnoremap c "_c
set nocompatible
filetype plugin on
set encoding=utf-8
set number relativenumber

" Enable autocompletion
set wildmode=longest,list,full

" Disables automatic commenting on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Nerd tree
map <leader>n :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
  let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
  let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif


" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
