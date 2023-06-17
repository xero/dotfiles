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

-- cmd display (set to zero to autohide)
vim.opt.cmdheight = 1

-- syntax highlighting
vim.cmd [[
	syntax on
	filetype plugin on
	set t_Co=256
	set termguicolors
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
vim.opt.splitbelow = true
vim.opt.splitright = true
