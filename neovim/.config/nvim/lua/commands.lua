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
local f = require("utils.functions")
local r = require("utils.remaps")

-- json pretty print
r.noremap("n", "<leader>j", ":%!jq .<cr>", "jq format")

-- remove highlighting
r.noremap("n", "<esc><esc>", ":nohlsearch<cr>", "remove highlighting", { silent = true })

-- remove trailing white space
f.cmd("Nows", "%s/\\s\\+$//e", { desc = "remove trailing whitespace" })

-- remove blank lines
f.cmd("Nobl", "g/^\\s*$/d", { desc = "remove blank lines" })

-- spell check
f.cmd("Sp", "setlocal spell! spell?", { desc = "toggle spell check" })
r.noremap("n", "<leader>s", ":Sp<cr>", "toggle spell check")

-- ios keeb
r.noremap("n", "<a-left>", "0", "ios home key")
r.noremap("i", "<a-left>", "0", "ios home key")

-- pseudo tail functionality
f.cmd("Tail", 'set autoread | au CursorHold * checktime | call feedkeys("G")', { desc = "pseudo tail functionality" })

-- make current buffer executable
f.cmd("Chmodx", "!chmod a+x %", { desc = "make current buffer executable" })

-- fix syntax highlighting
f.cmd("FixSyntax", "syntax sync fromstart", { desc = "reload syntax highlighting" })

-- vertical term
f.cmd("T", ":vs | :set nu! | :term", { desc = "vertical terminal" })

-- show treesitter capture group for textobject under cursor.
r.noremap("n", "<C-e>", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, "show treesitter capture group")
