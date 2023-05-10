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

" make inline more readable
function! UnMinify( )
    %s/{\ze[^\r\n]/{\r/g
    %s/){/) {/g
    %s/};\?\ze[^\r\n]/\0\r/g
    %s/;\ze[^\r\n]/;\r/g
    %s/[^\s]\zs[=&|]\+\ze[^\s]/ \0 /g
    normal ggVG=
endfunction
command! UnMinify :call UnMinify()
nnoremap <silent> <leader>u <esc>:call UnMinify()<cr><esc>

" json pretty print
nnoremap <silent> <leader>j <esc>:%!jq .<cr><esc>

" remove highlighting
nnoremap <silent> <esc><esc> :nohlsearch<cr><esc>

" remove trailing white space
command! Nows :%s/\s\+$//

" remove blank lines
command! Nobl :g/^\s*$/d

" toggle spellcheck
command! Spell :setlocal spell! spell?
nnoremap <leader>s :Spell<cr>

" ios home key hax
nnoremap <a-left> 0
inoremap <a-left> 0

" reload configs
command! ReloadVIMRC :source $MYVIMRC
nnoremap <silent> <leader>r <esc>:source $MYVIMRC<cr><esc>

" make current buffer executable
command! Chmodx :!chmod a+x %

" fix syntax highlighting
command! FixSyntax :syntax sync fromstart

" pseudo tail functionality
command! Tail :set autoread | au CursorHold * checktime | call feedkeys("G")

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
command! Zoom call s:Zoom()
nnoremap <leader>z :call Zoom()<cr>
inoremap <leader>z <ESC>:call Zoom()<cr>a

" textmode art!
function! AsciiMode()
  e ++enc=cp850
  set nu!
  set virtualedit=all
  set colorcolumn=80
endfunction
command! Ascii :call AsciiMode()

" ascii percent decoding
function! URLdecode(str) abort
  let str = substitute(substitute(substitute(a:str,'%0[Aa]\n$','%0A',''),'%0[Aa]','\n','g'),'+',' ','g')
  return iconv(substitute(str,'%\(\x\x\)','\=nr2char("0x".submatch(1))','g'), 'utf-8', 'latin1')
endfunction
command! URLdecode :call URLdecode()
