return {
	"jay-babu/mason-null-ls.nvim",
	cmd = "Mason",
	config = function()
		local mason_null_ls = require("mason-null-ls")
		mason_null_ls.setup({
			ensure_installed = {
				'shellcheck',
				'yamllint',
				'lualint',
				'pylint',
			},
			automatic_installation = true,
			automatic_setup = false,
		})
	end,
	dependencies = { "williamboman/mason.nvim" },
}
