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

set runtimepath+=~/.config/nvim/
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent call system('mkdir -p ~/.config/nvim/{autoload,bundle,cache,undo,backups,swaps,plugged}')
  silent call system('curl -fLo ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.config/nvim/autoload/plug.vim'
  augroup plugsetup | au!
    autocmd VimEnter * silent!  PlugInstall <ZZ>
  augroup end
endif

call plug#begin('~/.config/nvim/plugged')

" colors
Plug 'xero/sourcerer.vim'
Plug 'xero/blaquemagick.vim'
Plug 'xero/vim-noctu'
Plug 'xero/nord-vim-mod'

" programming
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp', { 'do': 'pip install -r requirements.txt' }
Plug 'ojroques/nvim-osc52'
Plug 'ojroques/vim-oscyank'
Plug 'shougo/deoplete.nvim', has('nvim') ? {} : { 'do': [ ':UpdateRemotePlugins', ':set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/' ]}
Plug 'vim-scripts/VimCompletesMe'
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
Plug 'mattn/vim-sl'

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/gv.vim', { 'on': 'GV' }
Plug 'rbong/vim-flog'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }

" multiplexer integration
"Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'
Plug 'melonmanchan/vim-tmux-resizer'

call plug#end()
