return {
	-- "folke/trouble.nvim",
	"xero/trouble.nvim", -- till my pr is merged
	branch = "custom-indent",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			auto_fold = false,
			fold_open = " ",
			fold_closed = " ",
			height = 6,
			indent_str = " ┊   ",
			include_declaration = {
				"lsp_references",
				"lsp_implementations",
				"lsp_definitions"
			},
			mode = "workspace_diagnostics",
			multiline = true,
			padding = false,
			position = "bottom",
			severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
			signs = require("utils.icons").diagnostics,
			use_diagnostic_signs = true,
		})
		local r = require("utils.remaps")
		r.noremap("n", "<leader>lr", ":TroubleToggle lsp_references<cr>", "lsp references ")
		r.noremap("n", "<leader>le", ":TroubleToggle document_diagnostics<cr>", "diagnostics")
		r.noremap("n", "<leader>t", function()
			require("lsp_lines").toggle()
			vim.cmd [[TroubleToggle workspace_diagnostics]]
		end, "toggle trouble  ")
	end,
}
