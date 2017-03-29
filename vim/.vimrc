colo desert
syntax on
filetype plugin indent on

set number
set mouse=a
set encoding=utf8
set autoindent

"# indicates col 80
if exists('+colorcolumn')
	set colorcolumn=80
	highlight colorcolumn ctermbg=5*
endif

"# autocomplete on :
set wildmenu

"# highlight search term.
set hlsearch
