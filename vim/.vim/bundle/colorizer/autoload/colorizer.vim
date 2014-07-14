" colorizer.vim	Colorize all text in the form #rrggbb or #rgb; autoload functions
" Maintainer:	lilydjwg <lilydjwg@gmail.com>
" Version:	1.4.1
" License:	Vim License  (see vim's :help license)
"
" See plugin/colorizer.vim for more info.

let s:keepcpo = &cpo
set cpo&vim

function! s:FGforBG(bg) "{{{1
  " takes a 6hex color code and returns a matching color that is visible
  let pure = substitute(a:bg,'^#','','')
  let r = str2nr(pure[0:1], 16)
  let g = str2nr(pure[2:3], 16)
  let b = str2nr(pure[4:5], 16)
  let fgc = g:colorizer_fgcontrast
  if r*30 + g*59 + b*11 > 12000
    return s:predefined_fgcolors['dark'][fgc]
  else
    return s:predefined_fgcolors['light'][fgc]
  end
endfunction

function! s:Rgb2xterm(color) "{{{1
  " selects the nearest xterm color for a rgb value like #FF0000
  let best_match=0
  let smallest_distance = 10000000000
  let r = str2nr(a:color[0:1], 16)
  let g = str2nr(a:color[2:3], 16)
  let b = str2nr(a:color[4:5], 16)
  let colortable = s:GetXterm2rgbTable()
  for c in range(0,254)
    let d = pow(colortable[c][0]-r,2) + pow(colortable[c][1]-g,2) + pow(colortable[c][2]-b,2)
    if d<smallest_distance
      let smallest_distance = d
      let best_match = c
    endif
  endfor
  return best_match
endfunction

"" the 6 value iterations in the xterm color cube {{{1
let s:valuerange = [0x00, 0x5F, 0x87, 0xAF, 0xD7, 0xFF]

"" 16 basic colors {{{1
let s:basic16 = [
      \ [0x00, 0x00, 0x00], [0xCD, 0x00, 0x00],
      \ [0x00, 0xCD, 0x00], [0xCD, 0xCD, 0x00],
      \ [0x00, 0x00, 0xEE], [0xCD, 0x00, 0xCD],
      \ [0x00, 0xCD, 0xCD], [0xE5, 0xE5, 0xE5],
      \ [0x7F, 0x7F, 0x7F], [0xFF, 0x00, 0x00],
      \ [0x00, 0xFF, 0x00], [0xFF, 0xFF, 0x00],
      \ [0x5C, 0x5C, 0xFF], [0xFF, 0x00, 0xFF],
      \ [0x00, 0xFF, 0xFF], [0xFF, 0xFF, 0xFF]]

function! s:Xterm2rgb(color) "{{{1
  " 16 basic colors
  let r = 0
  let g = 0
  let b = 0
  if a:color<16
    let r = s:basic16[a:color][0]
    let g = s:basic16[a:color][1]
    let b = s:basic16[a:color][2]
  endif

  " color cube color
  if a:color>=16 && a:color<=232
    let l:color=a:color-16
    let r = s:valuerange[(l:color/36)%6]
    let g = s:valuerange[(l:color/6)%6]
    let b = s:valuerange[l:color%6]
  endif

  " gray tone
  if a:color>=233 && a:color<=253
    let r=8+(a:color-232)*0x0a
    let g=r
    let b=r
  endif
  let rgb=[r,g,b]
  return rgb
endfunction

function! s:SetMatcher(color, pat) "{{{1
  " "color" is the converted color and "pat" is what to highlight
  let group = 'Color' . strpart(a:color, 1)
  if !hlexists(group) || s:force_group_update
    let fg = g:colorizer_fgcontrast < 0 ? a:color : s:FGforBG(a:color)
    if &t_Co == 256
      exe 'hi '.group.' ctermfg='.s:Rgb2xterm(fg).' ctermbg='.s:Rgb2xterm(a:color)
    endif
    " Always set gui* as user may switch to GUI version and it's cheap
    exe 'hi '.group.' guifg='.fg.' guibg='.a:color
  endif
  if !exists("w:colormatches[a:pat]")
    let w:colormatches[a:pat] = matchadd(group, a:pat)
  endif
endfunction

"ColorFinders {{{1
function! s:HexCode(str, lineno) "{{{2
  let ret = []
  let place = 0
  let colorpat = '#[0-9A-Fa-f]\{3\}\>\|#[0-9A-Fa-f]\{6\}\>'
  while 1
    let foundcolor = matchstr(a:str, colorpat, place)
    if foundcolor == ''
      break
    endif
    let place = matchend(a:str, colorpat, place)
    let pat = foundcolor . '\>'
    if len(foundcolor) == 4
      let foundcolor = substitute(foundcolor, '[[:xdigit:]]', '&&', 'g')
    endif
    call add(ret, [foundcolor, pat])
  endwhile
  return ret
endfunction

function! s:RgbColor(str, lineno) "{{{2
  let ret = []
  let place = 0
  let colorpat = '\<rgb(\v\s*(\d+(\%)?)\s*,\s*(\d+%(\2))\s*,\s*(\d+%(\2))\s*\)'
  while 1
    let foundcolor = matchlist(a:str, colorpat, place)
    if empty(foundcolor)
      break
    endif
    let place = matchend(a:str, colorpat, place)
    if foundcolor[2] == '%'
      let r = foundcolor[1] * 255 / 100
      let g = foundcolor[3] * 255 / 100
      let b = foundcolor[4] * 255 / 100
    else
      let r = foundcolor[1]
      let g = foundcolor[3]
      let b = foundcolor[4]
    endif
    if r > 255 || g > 255 || b > 255
      break
    endif
    let pat = printf('\<rgb(\v\s*%s\s*,\s*%s\s*,\s*%s\s*\)', foundcolor[1], foundcolor[3], foundcolor[4])
    if foundcolor[2] == '%'
      let pat = substitute(pat, '%', '\\%', 'g')
    endif
    let l:color = printf('#%02x%02x%02x', r, g, b)
    call add(ret, [l:color, pat])
  endwhile
  return ret
endfunction

function! s:RgbaColor(str, lineno) "{{{2
  if has("gui_running")
    let bg = synIDattr(synIDtrans(hlID("Normal")), "bg")
    let bg_r = str2nr(bg[1].bg[2], 16)
    let bg_g = str2nr(bg[3].bg[4], 16)
    let bg_b = str2nr(bg[5].bg[6], 16)
  else
    " translucent colors would display incorrectly, so ignore the alpha value
    return s:RgbaColorForTerm(a:str, a:lineno)
  endif
  let ret = []
  let place = 0
  let colorpat = '\<rgba(\v\s*(\d+(\%)?)\s*,\s*(\d+%(\2))\s*,\s*(\d+%(\2))\s*,\s*(-?[.[:digit:]]+)\s*\)'
  while 1
    let foundcolor = matchlist(a:str, colorpat, place)
    if empty(foundcolor)
      break
    endif
    let place = matchend(a:str, colorpat, place)
    if foundcolor[2] == '%'
      let ar = foundcolor[1] * 255 / 100
      let ag = foundcolor[3] * 255 / 100
      let ab = foundcolor[4] * 255 / 100
    else
      let ar = foundcolor[1]
      let ag = foundcolor[3]
      let ab = foundcolor[4]
    endif
    if ar > 255 || ag > 255 || ab > 255
      break
    endif
    let alpha = str2float(foundcolor[5])
    if alpha < 0
      let alpha = 0.0
    elseif alpha > 1
      let alpha = 1.0
    endif
    let pat = printf('\<rgba(\v\s*%s\s*,\s*%s\s*,\s*%s\s*,\s*%s0*\s*\)', foundcolor[1], foundcolor[3], foundcolor[4], foundcolor[5])
    if foundcolor[2] == '%'
      let pat = substitute(pat, '%', '\\%', 'g')
    endif
    let r = float2nr(ceil(ar * alpha) + ceil(bg_r * (1 - alpha)))
    let g = float2nr(ceil(ag * alpha) + ceil(bg_g * (1 - alpha)))
    let b = float2nr(ceil(ab * alpha) + ceil(bg_b * (1 - alpha)))
    if r > 255
      let r = 255
    endif
    if g > 255
      let g = 255
    endif
    if b > 255
      let b = 255
    endif
    let l:color = printf('#%02x%02x%02x', r, g, b)
    call add(ret, [l:color, pat])
  endwhile
  return ret
endfunction

function! s:RgbaColorForTerm(str, lineno) "{{{2
  let ret = []
  let place = 0
  let colorpat = '\<rgba(\v\s*(\d+(\%)?)\s*,\s*(\d+%(\2))\s*,\s*(\d+%(\2))\s*,\s*(-?[.[:digit:]]+)\s*\)'
  while 1
    let foundcolor = matchlist(a:str, colorpat, place)
    if empty(foundcolor)
      break
    endif
    let place = matchend(a:str, colorpat, place)
    if foundcolor[2] == '%'
      let ar = foundcolor[1] * 255 / 100
      let ag = foundcolor[3] * 255 / 100
      let ab = foundcolor[4] * 255 / 100
    else
      let ar = foundcolor[1]
      let ag = foundcolor[3]
      let ab = foundcolor[4]
    endif
    if ar > 255 || ag > 255 || ab > 255
      break
    endif
    let pat = printf('\<rgba(\v\s*%s\s*,\s*%s\s*,\s*%s\s*,\ze\s*(-?[.[:digit:]]+)\s*\)', foundcolor[1], foundcolor[3], foundcolor[4])
    if foundcolor[2] == '%'
      let pat = substitute(pat, '%', '\\%', 'g')
    endif
    let l:color = printf('#%02x%02x%02x', ar, ag, ab)
    call add(ret, [l:color, pat])
  endwhile
  return ret
endfunction

function! s:PreviewColorInLine(where) "{{{1
  let line = getline(a:where)
  for Func in s:ColorFinder
    let ret = Func(line, a:where)
    " returned a list of a list: color as #rrggbb, text pattern to highlight
    for r in ret
      call s:SetMatcher(r[0], r[1])
    endfor
  endfor
endfunction

function! s:CursorMoved() "{{{1
  if !exists('w:colormatches')
    return
  endif
  if exists('b:colorizer_last_update')
    if b:colorizer_last_update == b:changedtick
      " Nothing changed
      return
    endif
  endif
  call s:PreviewColorInLine('.')
  let b:colorizer_last_update = b:changedtick
endfunction

function! s:TextChanged() "{{{1
  if !exists('w:colormatches')
    return
  endif
  echomsg "TextChanged"
  call s:PreviewColorInLine('.')
endfunction

function! colorizer#ColorHighlight(update, ...) "{{{1
  if exists('w:colormatches')
    if !a:update
      return
    endif
    call s:ClearMatches()
  endif
  let w:colormatches = {}
  if g:colorizer_fgcontrast != s:saved_fgcontrast || (exists("a:1") && a:1 == '!')
    let s:force_group_update = 1
  endif
  for i in range(1, line("$"))
    call s:PreviewColorInLine(i)
  endfor
  let s:force_group_update = 0
  let s:saved_fgcontrast = g:colorizer_fgcontrast
  augroup Colorizer
    au!
    if exists('##TextChanged')
      autocmd TextChanged * silent call s:TextChanged()
      if v:version > 704 || v:version == 704 && has('patch143')
        autocmd TextChangedI * silent call s:TextChanged()
      else
        " TextChangedI does not work as expected
        autocmd CursorMovedI * silent call s:CursorMoved()
      endif
    else
      autocmd CursorMoved,CursorMovedI * silent call s:CursorMoved()
    endif
    " rgba handles differently, so need updating
    autocmd GUIEnter * silent call colorizer#ColorHighlight(1)
    autocmd BufRead * silent call colorizer#ColorHighlight(1)
    autocmd WinEnter * silent call colorizer#ColorHighlight(1)
    autocmd ColorScheme * let s:force_group_update=1 | silent call colorizer#ColorHighlight(1)
  augroup END
endfunction

function! colorizer#ColorClear() "{{{1
  augroup Colorizer
    au!
  augroup END
  let save_tab = tabpagenr()
  let save_win = winnr()
  tabdo windo call s:ClearMatches()
  exe 'tabn '.save_tab
  exe save_win . 'wincmd w'
endfunction

function! s:ClearMatches() "{{{1
  if !exists('w:colormatches')
    return
  endif
  for i in values(w:colormatches)
    call matchdelete(i)
  endfor
  unlet w:colormatches
endfunction

function! colorizer#ColorToggle() "{{{1
  if exists('#Colorizer#BufRead')
    call colorizer#ColorClear()
    echomsg 'Disabled color code highlighting.'
  else
    call colorizer#ColorHighlight(0)
    echomsg 'Enabled color code highlighting.'
  endif
endfunction

function! s:GetXterm2rgbTable()
  if !exists('s:table_xterm2rgb')
    let s:table_xterm2rgb = []
    for c in range(0, 254)
      let s:color = s:Xterm2rgb(c)
      call add(s:table_xterm2rgb, s:color)
    endfor
  endif
  return s:table_xterm2rgb
endfun

" Setups {{{1
let s:ColorFinder = [function('s:HexCode'), function('s:RgbColor'), function('s:RgbaColor')]
let s:force_group_update = 0
let s:predefined_fgcolors = {}
let s:predefined_fgcolors['dark']  = ['#444444', '#222222', '#000000']
let s:predefined_fgcolors['light'] = ['#bbbbbb', '#dddddd', '#ffffff']
if !exists("g:colorizer_fgcontrast")
  " Default to black / white
  let g:colorizer_fgcontrast = len(s:predefined_fgcolors['dark']) - 1
elseif g:colorizer_fgcontrast >= len(s:predefined_fgcolors['dark'])
  echohl WarningMsg
  echo "g:colorizer_fgcontrast value invalid, using default"
  echohl None
  let g:colorizer_fgcontrast = len(s:predefined_fgcolors['dark']) - 1
endif
let s:saved_fgcontrast = g:colorizer_fgcontrast

" Restoration and modelines {{{1
let &cpo = s:keepcpo
unlet s:keepcpo
" vim:ft=vim:fdm=marker:fmr={{{,}}}:
