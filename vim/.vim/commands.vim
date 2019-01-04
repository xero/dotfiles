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

" json pretty print
function! JSONify()
  %!python -mjson.tool
  set syntax=json
endfunction
command J :call JSONify()
nnoremap <silent> <leader>j <esc>:call JSONify()<cr><esc>

" make inline more readable
function! UnMinify( )
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
command UnMinify :call UnMinify()
nnoremap <silent> <leader>u <esc>:call UnMinify()<cr><esc>

" remove highlighting
nnoremap <silent> <esc><esc> <esc>:nohlsearch<cr><esc>

" remove trailing white space
command Nows :%s/\s\+$//

" remove blank lines
command Nobl :g/^\s*$/d

" toggle spellcheck
command Spell :setlocal spell! spell?
nnoremap <silent> <leader>s :setlocal spell! spell?

" make current buffer executable
command Chmodx :!chmod a+x %

" fix syntax highlighting
command FixSyntax :syntax sync fromstart

" pseudo tail functionality
command Tail :set autoread | au CursorHold * checktime | call feedkeys("G")

" zoom
function! Zoom() abort
  if winnr('$') > 1
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
  else
    execute "silent !tmux resize-pane -Z"
  endif
endfunction
command Zoom call s:Zoom()
nnoremap <leader>z :call Zoom()<cr>
inoremap <leader>z <ESC>:call Zoom()<cr>a

" let's make some textmode art!
function! AsciiMode()
  e ++enc=cp850
  set nu!
  set virtualedit=all
  set colorcolumn=80
endfunction
command Ascii :call AsciiMode()
