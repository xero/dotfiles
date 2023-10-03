return {
	"williamboman/mason.nvim",
	build = ":MasonInstallAll",
	config = function()
		local f = require("utils.functions")
		require("mason").setup({
			ui = {
				border = "shadow",
				icons = require("utils.icons").mason,
				zindex = 99,
			},
		})
		f.cmd("MasonInstallAll", function()
			vim.cmd('MasonUpdate')
			local ensure_installed = {
				"bash-language-server",
				"black",
				"clang-format",
				"css-lsp",
				"dockerfile-language-server",
				"eslint-lsp",
				"html-lsp",
				"json-lsp",
				"lua-language-server",
				"php-cs-fixer",
				"prettierd",
				"python-lsp-server",
				"rust-analyzer",
				"shellcheck",
				"shellharden",
				"shfmt",
				"stylua",
				"tailwindcss-language-server",
				"terraform-ls",
				"tflint",
				"typescript-language-server",
				"yaml-language-server",
			}
			vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
		end, { desc = "install all lsp tools" })
	end,
}
