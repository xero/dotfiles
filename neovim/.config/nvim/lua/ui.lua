--           ██
--          ░░
--  ██    ██ ██ ██████████  ██████  █████
-- ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██
-- ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░
--  ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██
--   ░░██   ░██ ███ ░██ ░██░███   ░░█████
--    ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ xero <x@xero.style>
-- ░▓ code   ▓ https://code.x-e.ro/dotfiles
-- ░▓ mirror ▓ https://git.io/.files
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░
--
-- show matching brackets/parenthesis
vim.opt.showmatch = true

-- disable startup message
vim.opt.shortmess:append 'sI'

-- hide mode display
-- set showmode = false

-- syntax highlighting
vim.cmd [[
	syntax on
	filetype plugin on
]]
vim.opt.synmaxcol=512

-- show line numbers
vim.opt.number = true

-- default no line wrapping
vim.opt.wrap = false

-- set indents when wrapped
vim.opt.breakindent = true

-- highlight cursor
vim.opt.cursorline = true
-- set cursorcolumn = true

-- show invisibles
vim.opt.listchars = { tab = '··', trail = '·', extends = '»',  precedes = '«', nbsp = '░' }
vim.opt.list = true

-- split style
vim.opt.fillchars = { vert = '▒' }

-- tree style file explorer
vim.g['netrw_liststyle'] = 3
vim.g['netrw_browse_split'] = 4
vim.g['netrw_winsize'] = 25

-- darken inactive panes
vim.cmd [[
	hi SignColumn   ctermbg=234
	hi ActiveWindow ctermbg=0 | hi InactiveWindow ctermbg=234
]]
vim.opt.winhighlight = 'Normal:ActiveWindow,NormalNC:InactiveWindow'
