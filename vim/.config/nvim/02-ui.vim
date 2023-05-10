"           ██
"          ░░
"  ██    ██ ██ ██████████  ██████  █████
" ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
" ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
"  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
"   ░░██   ░██ ███ ░██ ░██░███   ░░█████
"    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
"
"  ▓▓▓▓▓▓▓▓▓▓
" ░▓ author ▓ xero <x@xero.style>
" ░▓ code   ▓ https://code.x-e.ro/dotfiles
" ░▓ mirror ▓ https://git.io/.files
" ░▓▓▓▓▓▓▓▓▓▓
" ░░░░░░░░░░
"
" show matching brackets/parenthesis
set showmatch

" disable startup message
set shortmess+=I

" hide mode display
"set noshowmode

" syntax highlighting
syntax on
set synmaxcol=512
filetype plugin on

" stop unnecessary rendering
"set lazyredraw

" show line numbers
set number

" default no line wrapping
set nowrap

" set indents when wrapped
set breakindent

" highlight cursor
set cursorline
"set cursorcolumn

" show invisibles
set list
set listchars=
set listchars+=tab:·\ 
set listchars+=trail:·
set listchars+=extends:»
set listchars+=precedes:«
set listchars+=nbsp:░

" split style
set fillchars=vert:▒

" tree style file explorer
let g:netrw_liststyle=3
let g:netrw_browse_split=4
let g:netrw_winsize=25

" darken inactive panes
hi SignColumn   ctermbg=234
hi ActiveWindow ctermbg=0 | hi InactiveWindow ctermbg=234
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
