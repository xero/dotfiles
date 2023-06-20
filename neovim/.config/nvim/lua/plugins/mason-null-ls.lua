return {
	"jay-babu/mason-null-ls.nvim",
	dependencies = { "williamboman/mason.nvim" },
	cmd = "Mason",
	config = function()
		local mason_null_ls = require("mason-null-ls")
		mason_null_ls.setup({
			ensure_installed = {
				'bashls',
				'cssls',
				'dockerls',
				'eslint',
				'eslint_d',
				'gopls',
				'graphql',
				'html',
				'jq',
				'jsonls',
				'lua_ls',
				'luacheck',
				'lualint',
				'pylint',
				'shellcheck',
				'shfmt',
				'stylua',
				'terraformls',
				'texlab',
				'tflint',
				'yamlfmt',
				'yamllint',
			},
			automatic_installation = true,
			automatic_setup = false,
		})
	end,
}
