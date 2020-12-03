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
" ░▓ author ▓ xero <x@xero.nu>
" ░▓ code   ▓ http://code.xero.nu/dotfiles
" ░▓ mirror ▓ http://git.io/.files
" ░▓▓▓▓▓▓▓▓▓▓
" ░░░░░░░░░░
"
set runtimepath+=~/.vim/

if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('mkdir -p ~/.vim/{autoload,bundle,cache,undo,backups,swaps}')
  silent call system('curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.vim/autoload/plug.vim'
  augroup plugsetup
    au!
    autocmd VimEnter * PlugInstall
  augroup end
endif

call plug#begin('~/.vim/plugged')

Plug 'mattn/vim-sl'

" colors
Plug 'xero/sourcerer.vim'
Plug 'xero/blaquemagick.vim'
Plug 'xero/vim-noctu'
Plug 'xero/nord-vim-mod'

" programming
Plug 'shougo/deoplete.nvim', has('nvim') ? {} : { 'do': [ ':UpdateRemotePlugins', ':set runtimepath+=~/.vim/plugged/deoplete.nvim/' ]}
Plug 'ajh17/VimCompletesMe'
Plug 'w0rp/ale'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" stylize
Plug 'xero/nerdtree'
Plug 'ntpeters/vim-better-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'chrisbra/colorizer'
Plug 'chrisbra/unicode.vim'
Plug 'powerman/vim-plugin-AnsiEsc'

" features
Plug 'rking/ag.vim'
Plug 'xero/vim-move'
Plug 'andymass/vim-matchup'
Plug 'godlygeek/tabular'
Plug 'tpope/tpope-vim-abolish'
Plug 'xero/securemodelines'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
"Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'rbong/vim-flog', { 'on': 'Flog' }
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" multiplexer integration
Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'

call plug#end()
