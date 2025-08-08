return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"RRethy/nvim-treesitter-textsubjects",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local r = require("utils.remaps")
		---@diagnostic disable-next-line
		require('nvim-treesitter.configs').setup{
			ensure_installed = {
				"bash",
				"c",
				"css",
				"dockerfile",
				"go",
				"graphql",
				"hcl",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"php",
				"python",
				"query",
				"regex",
				"ruby",
				"rust",
				"scss",
				"sql",
				"terraform",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"yaml",
			},
			highlight = {
				enable = true,
			},
			match = {
				enable = true,
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
			indent = {
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
			textsubjects = {
				enable = true,
				keymaps = {
					["."] = "textsubjects-smart",
					[";"] = "textsubjects-container-outer",
					["i;"] = "textsubjects-container-inner",
				},
			},
		}

		r.noremap("n", "<leader>rt", function()
			vim.treesitter.inspect_tree({ command = "botleft60vnew" })
		end, "treesitter playground")

		r.noremap("n", "<C-e>", function()
			local result = vim.treesitter.get_captures_at_cursor(0)
			print(vim.inspect(result))
		end, "show treesitter capture group")

		r.map_virtual({
			{ "<leader>r", group = "refactor", icon = { icon = " ", hl = "Constant" } },
			{ "<leader>rt", group = "treesitter playground", icon = { icon = " ", hl = "Constant" } },
			{ "<leader>rp", group = "swap parameter next", icon = { icon = "󰯍 ", hl = "Constant" } },
			{ "<leader>rP", group = "swap parameter prev", icon = { icon = "󰯍 ", hl = "Constant" } },
			{ "zi", group = "init selection"},
			{ "zn", group = "expand node"},
			{ "zo", group = "expand scope"},
			{ "zd", group = "decrement scope"},
		})
	end,
	build = function()
		vim.cmd(":TSUpdate")
	end,
}
