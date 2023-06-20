return {
	"jose-elias-alvarez/null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	config = function()
		local nls = require("null-ls")
		local formatting = nls.builtins.formatting
		local diagnostics = nls.builtins.diagnostics
		local code_actions = nls.builtins.code_actions

		nls.setup({
			debug = false,
			sources = {
				diagnostics.shellcheck,
				diagnostics.zsh,
				diagnostics.yamllint,
				diagnostics.golangci_lint,
				diagnostics.gitlint,
				diagnostics.jsonlint,
				formatting.stylua,
				formatting.prettierd,
				formatting.jq,
				formatting.shfmt,
				code_actions.gitsigns,
				code_actions.refactoring,
				code_actions.shellcheck,
			},
		})
	end,
}
