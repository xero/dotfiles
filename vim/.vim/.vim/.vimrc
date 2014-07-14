"█▓▒░ autoload
execute pathogen#infect()

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts   = 0
let g:airline_theme             = 'tomorrow'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '▒'
let g:airline_left_alt_sep = '▒'
let g:airline_right_sep = '▒'
let g:airline_right_alt_sep = '▒'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.linenr = '░'
let g:airline_symbols.linenr = '░'
let g:airline_symbols.linenr = '░'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = '░'
let g:airline_symbols.readonly = 'x'

let g:startify_custom_header = [
                \ '',
                \ '          ██           ██                ████            ██            ',
                \ '         ░██          ░██               ░██░            ░░             ',
                \ '  █████  ░██ ██   ██ ██████    ██████  ██████   ██    ██ ██ ██████████ ',
                \ ' ██░░░██ ░██░██  ░██░░░██░    ██░░░░██░░░██░   ░██   ░██░██░░██░░██░░██',
                \ '░██  ░░  ░██░██  ░██  ░██    ░██   ░██  ░██    ░░██ ░██ ░██ ░██ ░██ ░██',
                \ '░██   ██ ░██░██  ░██  ░██    ░██   ░██  ░██     ░░████  ░██ ░██ ░██ ░██',
                \ '░░█████  ███░░██████  ░░██   ░░██████   ░██      ░░██   ░██ ███ ░██ ░██',
                \ ' ░░░░░  ░░░  ░░░░░░    ░░     ░░░░░░    ░░        ░░    ░░ ░░░  ░░  ░░ ',
                \ '',
                \ ]

set laststatus=2
set lazyredraw

syntax on
colorscheme monokai
filetype plugin indent on
