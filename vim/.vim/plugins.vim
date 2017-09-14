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

if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('mkdir -p ~/.vim/{autoload,bundle,cache,undo,backups,swaps}')
  silent call system('curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source  ~/.vim/autoload/plug.vim'
  autocmd VimEnter * PlugInstall
else
  execute 'source  ~/.vim/autoload/plug.vim'
endif

set runtimepath+=~/.vim/plugged/deoplete.nvim/
call plug#begin('~/.vim/plugged')

" colors
Plug 'xero/sourcerer.vim'
Plug 'xero/blaquemagick.vim'
Plug 'xero/vim-noctu'

" features
Plug 'shougo/deoplete.nvim', has('nvim') ? {} : { 'do': ':UpdateRemotePlugins' }
Plug 'ajh17/VimCompletesMe'
Plug 'w0rp/ale'
Plug 'isa/vim-matchit'
Plug 'romainl/vim-qf'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'itchyny/lightline.vim'
Plug 'lilydjwg/colorizer'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'
Plug 'rking/ag.vim'
Plug 'airblade/vim-gitgutter'
Plug 'simeji/winresizer'
Plug 'gregsexton/gitv', { 'on': 'Gitv' }
Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'junegunn/limelight.vim', { 'on': 'Goyo' }
Plug 'matze/vim-move'
Plug 'tpope/tpope-vim-abolish'
Plug 'majutsushi/tagbar', { 'on': 'Tagbar' }
Plug 'godlygeek/tabular'

" langs
Plug 'othree/html5.vim' , { 'for': ['html', 'htm', 'xhtml'] }
Plug 'shawncplus/phpcomplete.vim', { 'for': 'php' }
Plug 'gabrielelana/vim-markdown', { 'for': ['md', 'markdown'] }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'pangloss/vim-javascript', { 'for': 'js' }

call plug#end()
