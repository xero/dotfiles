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
" use vim settings, rather than vi settings
" must be first, because it changes other options as a side effect
set nocompatible

" paste without auto indentation
set paste

" maintain undo history between sessions
set undofile
set undodir=~/.vim/undo
set noswapfile

" file name tab completion
set wildmode=longest,list,full
set wildmenu

" make backspace behave in a sane manner
set backspace=indent,eol,start

" disable startup message
set shortmess+=I

" syntax highlighting and colors
syntax on
colorscheme sourcerer
filetype plugin indent on

" stop unnecessary rendering
set lazyredraw

" show line numbers
set number

" no line wrapping
set nowrap

" searching
set hlsearch
set incsearch

" no folding
set foldlevel=99
set foldminlines=99
 
" enable file type detection and do language-dependent indenting
if has("autocmd")
  filetype on
  filetype indent on
  filetype plugin on
endif

" let mapleader=","
vnoremap <silent> <leader>y :w !xsel -i -b<CR>
nnoremap <silent> <leader>y V:w !xsel -i -b<CR>
nnoremap <silent> <leader>p :silent :r !xsel -o -b<CR>

" remap code completion to ^space
inoremap <Nul> <C-x><C-o>

" █▓▒░ wizard status line
set laststatus=2

hi BgColor guibg=#3A3A3A guifg=#ffffff ctermbg=237 ctermfg=255
hi ModColor guibg=#3A3A3A guifg=#afaf00 ctermbg=237 ctermfg=142
hi StatColor guibg=#3a3a3a guifg=#ffffff ctermbg=237 ctermfg=255
hi GitColor guibg=#4e4e4e guifg=#ffffff ctermbg=239 ctermfg=255
hi VoidColor guibg=#222222 guifg=#4e4e4e ctermbg=NONE ctermfg=239
hi TypeColor guibg=#D78700 guifg=#262626 ctermbg=66 ctermfg=235
hi PosColor guibg=#8787AF guifg=#262626 ctermbg=103 ctermfg=235

function! WizardStatus(mode)
    let statusline="%#BgColor#"
    if &modified == 1
	let statusline.="%#ModColor# »» "
    else
    	let statusline.="    " 
    endif
    if &readonly != ''
        hi StatColor guifg=#af0000 ctermfg=124
    endif
    let statusline.="%#StatColor#%F " 
    "let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d'")
    let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if branch != ''
        let statusline .= '%#VoidColor#▓%#GitColor# ' . substitute(branch, '\n', '', 'g') . ' %#VoidColor#▓▒░ '
    else
	let statusline .= '%#VoidColor#▒░ '
    endif
    let statusline .= "%=%h%w\ %#TypeColor#▓"
    if &filetype != ''
        let statusline .="▒ %Y "
    endif
    let statusline .="▒ %{&encoding}:%{&fileformat} %#PosColor#▒ %p%% ░ %l/%L\.\%c\ ▒"
    return statusline
endfunction

au WinEnter * setlocal statusline=%!WizardStatus('Enter')
au WinLeave * setlocal statusline=%!WizardStatus('Leave')
set statusline=%!WizardStatus('Enter')

function! Colorize(mode)
  if a:mode == 'i'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=110 ctermfg=235
  elseif a:mode == 'r'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=172 ctermfg=235
  elseif a:mode == 'v'
    hi StatColor guibg=#D78700 guifg=#222222 ctermbg=172 ctermfg=235
  else
    hi StatColor guibg=#af0000 guifg=#222222 ctermbg=124  ctermfg=235
  endif
endfunction 

au InsertEnter * call Colorize(v:insertmode)
au InsertLeave * hi StatColor guibg=#3a3a3a guifg=#ffffff ctermbg=237 ctermfg=255

