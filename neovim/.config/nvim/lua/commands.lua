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

-- buffers
r.noremap("n", "<c-n>", ":bn<cr>", "next buffer")
r.noremap("n", "<c-p>", ":bp<cr>", "prev buffer")
r.noremap("n", "<c-x>", ":bd<cr>", "exit buffer")

-- tabs
r.noremap("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
r.noremap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
r.noremap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
r.noremap("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
r.noremap("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
r.noremap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

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
r.noremap("n", "<leader>x", ":Chmodx<cr>", "chmod +x buffer")

-- fix syntax highlighting
f.cmd("FixSyntax", "syntax sync fromstart", { desc = "reload syntax highlighting" })

-- vertical term
f.cmd("T", ":vs | :set nu! | :term", { desc = "vertical terminal" })

-- the worst place in the universe
r.noremap("n", "Q", "<nop>", "")

-- move blocks
r.noremap("v", "J", ":m '>+1<CR>gv=gv", "move block up")
r.noremap("v", "K", ":m '<-2<CR>gv=gv", "move block down")

-- focus scrolling
r.noremap("n", "<C-d>", "<C-d>zz", "scroll down")
r.noremap("n", "<C-u>", "<C-u>zz", "scroll up")

-- focus highlight searches
r.noremap("n", "n", "nzzzv", "next match")
r.noremap("n", "N", "Nzzzv", "prev match")

-- remove trailing whitespaces and ^M chars
f.autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function(_)
		local save_cursor = vim.fn.getpos(".")
		vim.cmd [[%s/\s\+$//e]]
		vim.fn.setpos(".", save_cursor)
	end,
})
