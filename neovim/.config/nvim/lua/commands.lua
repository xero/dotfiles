--                                     ██
--                                    ░░
--  ███████   █████   ██████  ██    ██ ██ ██████████
-- ░░██░░░██ ██░░░██ ██░░░░██░██   ░██░██░░██░░██░░██
--  ░██  ░██░███████░██   ░██░░██ ░██ ░██ ░██ ░██ ░██
--  ░██  ░██░██░░░░ ░██   ░██ ░░████  ░██ ░██ ░██ ░██
--  ███  ░██░░██████░░██████   ░░██   ░██ ███ ░██ ░██
-- ░░░   ░░  ░░░░░░  ░░░░░░     ░░    ░░ ░░░  ░░  ░░
--
--  ▓▓▓▓▓▓▓▓▓▓
-- ░▓ author ▓ xero <x@xero.style>
-- ░▓ code   ▓ https://code.x-e.ro/dotfiles
-- ░▓ mirror ▓ https://git.io/.files
-- ░▓▓▓▓▓▓▓▓▓▓
-- ░░░░░░░░░░
--
local key = vim.keymap.set
local cmd = vim.api.nvim_create_user_command
local r = require("utils.remaps")

-- json pretty print
key('n', '<leader>j', ':%!jq .<cr>')

-- remove highlighting
key('n', '<esc><esc>', ':nohlsearch<cr>', { silent = true })

-- remove trailing white space
cmd("Nows",
	"%s/\\s\\+$//e",
	{ desc = "remove trailing whitespace" }
)

-- remove blank lines
cmd("Nobl",
	"g/^\\s*$/d",
	{ desc = "remove blank lines" }
)

-- spell check
cmd("Sp",
	"setlocal spell! spell?",
	{ desc = "toggle spell check" }
)
key('n', '<leader>s', ':Sp<cr>')

-- ios keeb
key('n', '<a-left>', '0')
key('i', '<a-left>', '0')

-- pseudo tail functionality
cmd(
	"Tail",
	'set autoread | au CursorHold * checktime | call feedkeys("G")',
	{ desc = "pseudo tail functionality" }
)

-- make current buffer executable
cmd("Chmodx",
	'!chmod a+x %',
	{ desc = "make current buffer executable" }
)

-- fix syntax highlighting
cmd("FixSyntax",
	'syntax sync fromstart',
	{ desc = "reload syntax highlighting" }
)

-- vertical term
cmd("T",
	':vs | :set nu! | :term' ,
	{ desc = "vertical terminal" }
)
-- term mode remaps
r.noremap("t", "<c-h>", "<c-\\><c-n><c-w>h", "focus left")
r.noremap("t", "<c-h>", "<c-\\><c-n><c-w>j", "focus down")
r.noremap("t", "<c-h>", "<c-\\><c-n><c-w>k", "focus up")
r.noremap("t", "<c-h>", "<c-\\><c-n><c-w>l", "focus right")
