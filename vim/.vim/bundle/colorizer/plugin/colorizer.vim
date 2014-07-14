" colorizer.vim	Colorize all text in the form #rrggbb or #rgb; entrance
" Maintainer:	lilydjwg <lilydjwg@gmail.com>
" Version:	1.4.1
" Licence:	Vim license. See ':help license'
" Derived From: css_color.vim
" 		http://www.vim.org/scripts/script.php?script_id=2150
" Thanks To:	Niklas Hofer (Author of css_color.vim), Ingo Karkat, rykka,
"		KrzysztofUrban, blueyed, shanesmith, UncleBill
" Usage:
"
" This plugin defines three commands:
"
" 	ColorHighlight	- start/update highlighting
" 	ColorClear      - clear all highlights
" 	ColorToggle     - toggle highlights
"
" By default, <leader>tc is mapped to ColorToggle. If you want to use another
" key map, do like this:
" 	nmap ,tc <Plug>Colorizer
"
" If you want completely not to map it, set the following in your vimrc:
"	let g:colorizer_nomap = 1
"
" To use solid color highlight, set this in your vimrc (later change won't
" probably take effect unless you use ':ColorHighlight!' to force update):
"	let g:colorizer_fgcontrast = -1
" set it to 0 or 1 to use a softened foregroud color.
"
" If you don't want to enable colorizer at startup, set the following:
"	let g:colorizer_startup = 0
"
" Note: if you modify a color string in normal mode, if the cursor is still on
" that line, it'll take 'updatetime' seconds to update. You can use
" :ColorHighlight (or your key mapping) again to force update.
"
" Performace Notice: In terminal, it may take several seconds to highlight 240
" different colors. GUI version is much quicker.

" Reload guard and 'compatible' handling {{{1
if exists("loaded_colorizer") || v:version < 700 || !(has("gui_running") || &t_Co == 256)
  finish
endif
let loaded_colorizer = 1

let s:save_cpo = &cpo
set cpo&vim

"Define commands {{{1
command! -bar -bang ColorHighlight call colorizer#ColorHighlight(1, "<bang>")
command! -bar ColorClear call colorizer#ColorClear()
command! -bar ColorToggle call colorizer#ColorToggle()
nnoremap <silent> <Plug>Colorizer :ColorToggle<CR>
if !hasmapto("<Plug>Colorizer") && (!exists("g:colorizer_nomap") || g:colorizer_nomap == 0)
  nmap <unique> <Leader>tc <Plug>Colorizer
endif
if !exists('g:colorizer_startup') || g:colorizer_startup
  call colorizer#ColorHighlight(0)
endif

" Cleanup and modelines {{{1
let &cpo = s:save_cpo
" vim:ft=vim:fdm=marker:fmr={{{,}}}:
