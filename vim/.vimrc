set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Themes
Plugin 'mhartington/oceanic-next'
Plugin 'altercation/vim-colors-solarized'
Plugin 'morhetz/gruvbox'

" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'reedes/vim-thematic'

" Nerdtree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Git Helper
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Rails
Plugin 'tpope/vim-rails'

" Syntastic
Plugin 'scrooloose/syntastic'

" Languages
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'
Plugin 'jceb/vim-orgmode'
Plugin 'vimwiki/vimwiki'
Plugin 'mrtazz/simplenote.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set number

let g:airline_powerline_fonts = 1
let g:airline_theme='oceanicnext'

set background=dark
if has('gui_running')
    colorscheme OceanicNext
    set guifont=Hack:h16
elseif $TERM_PROGRAM=='iTerm.app'
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    colorscheme OceanicNext
endif
syntax on

" Default tab
set ts=4 sts=4 sw=4 expandtab

set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

filetype on

if has("autocmd")

    " Automatically open NERDTree on Startup
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 | NERDTree | endif

    " Indentation overides
    autocmd FileType ruby set ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript set ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript.jsx set ts=2 sts=2 sw=2 expandtab
    autocmd FileType html set ts=2 sts=2 sw=2 expandtab
    autocmd FileType lua set ts=2 sts=2 sw=2 expandtab
    autocmd FileType rust set ts=4 sts=4 sw=4 expandtab
    autocmd FileType eruby set ts=2 sts=2 sw=2 expandtab

    " Filetype extensions
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
endif

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'c', 'ruby', 'yaml']

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
