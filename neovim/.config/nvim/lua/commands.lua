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
r.noremap("n", "<leader><tab>l", "<cmd>tablast<cr>", "last tab")
r.noremap("n", "<leader><tab>f", "<cmd>tabfirst<cr>", "first tab")
r.noremap("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", "new tab")
r.noremap("n", "<leader><tab>]", "<cmd>tabnext<cr>", "next tab")
r.noremap("n", "<leader><tab>d", "<cmd>tabclose<cr>", "close tab")
r.noremap("n", "<leader><tab>[", "<cmd>tabprevious<cr>", "previous tab")
r.map_virtual({ "<leader><tab>", group = "tabs", icon = { icon = " ", hl = "Constant" } })

-- remove highlighting
r.noremap("n", "<esc><esc>", ":nohlsearch<cr>", "which_key_ignore", { silent = true })

-- remove trailing white space
f.cmd("Nows", "%s/\\s\\+$//e", { desc = "remove trailing whitespace" })

-- remove blank lines
f.cmd("Nobl", "g/^\\s*$/d", { desc = "remove blank lines" })

-- toggle wrapping
f.cmd("Wt", "setlocal wrap! nowrap?", { desc = "toggle line wrapping" })
r.noremap("n", "<leader>w", ":Wt<cr>", "toggle line wrapping")
r.map_virtual({ "<leader>w", group = "line wrap", icon = { icon = "󰖶", hl = "Constant" } })

-- spell check
f.cmd("Sp", "setlocal spell! spell?", { desc = "toggle spell check" })
r.noremap("n", "<leader>s", ":Sp<cr>", "toggle spell check")
r.map_virtual({ "<leader>s", group = "spell check", icon = { icon = "󰓆", hl = "Constant" } })

r.noremap("n", "<leader>C", function()
	local result = vim.treesitter.get_captures_at_cursor(0)
	print(vim.inspect(result))
end, "show highlight under cursor")
r.map_virtual({ "<leader>C", group = "highlight", icon = { icon = "󰨺", hl = "Constant" } })

-- pseudo tail functionality
f.cmd("Tail", 'set autoread | au CursorHold * checktime | call feedkeys("G")', { desc = "pseudo tail functionality" })

-- make current buffer executable
f.cmd("Chmodx", "!chmod a+x %", { desc = "make current buffer executable" })
r.noremap("n", "<leader>x", ":Chmodx<cr>", "chmod +x buffer")
r.map_virtual({ "<leader>x", group = "mark executable", icon = { icon = "", hl = "Constant" } })

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
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
})
