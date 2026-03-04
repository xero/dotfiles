-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ':TSUpdate',
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local r = require("utils.remaps")
		require'nvim-treesitter'.setup {
			install_dir = vim.fn.stdpath('data') .. '/site',
			match = {
				enable = true,
			},
			swap = {
				enable = true,
				swap_next = {
					["<leader>rp"] = "@parameter.inner",
				},
				swap_previous = {
					["<leader>rP"] = "@parameter.inner",
				},
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "zi",
					node_incremental = "zn",
					scope_incremental = "zo",
					node_decremental = "zd",
				},
			},
		}
		require'nvim-treesitter'.install {
			"bash", "c", "css", "dockerfile", "go",
			"graphql", "hcl", "html", "javascript",
			"json", "lua", "markdown", "markdown_inline",
			"php", "python", "query", "regex", "ruby",
			"rust", "scss", "sql", "terraform", "tsx",
			"typescript", "vim", "vimdoc", "yaml",
		}
		vim.api.nvim_create_autocmd('FileType', {
			pattern = { '<filetype>' },
			callback = function()
				vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
				vim.wo[0][0].foldmethod = 'expr'
				vim.treesitter.start()
			end,
		})

		r.noremap("n", "<leader>rt", function()
			vim.treesitter.inspect_tree({ command = "botleft60vnew" })
		end, "treesitter playground")

		r.noremap("n", "<C-e>", function()
			local result = vim.treesitter.get_captures_at_cursor(0)
			print(vim.inspect(result))
		end, "show treesitter capture group")

		r.map_virtual({
			{ "<leader>r", group = "refactor", icon = { icon = " ", hl = "Constant" } },
			{ "z", group = "Treesitter", icon = { icon = "󰐅", hl = "Constant" } },
			{ "<leader>rt", group = "treesitter playground", icon = { icon = " ", hl = "Constant" } },
			{ "<leader>rp", group = "swap parameter next", icon = { icon = "󰯍 ", hl = "Constant" } },
			{ "<leader>rP", group = "swap parameter prev", icon = { icon = "󰯍 ", hl = "Constant" } },
			{ "zi", group = "init selection" },
			{ "zn", group = "expand node" },
			{ "zo", group = "expand scope" },
			{ "zd", group = "decrement scope" },
		})
	end,
}
