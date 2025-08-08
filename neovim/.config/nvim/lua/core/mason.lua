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

			local function filter_missing_tools(tools)
				local missing = {}
				for _, tool in ipairs(tools) do
					if vim.fn.executable(tool) ~= 1 then
						table.insert(missing, tool)
					end
				end
				return missing
			end

			vim.cmd('MasonUpdate')
			local ensure_installed = {
				"bash-language-server",
				"black",
				"clang-format",
				"clangd",
				"css-lsp",
				"dockerfile-language-server",
				"eslint-lsp",
				"html-lsp",
				"intelephense",
				"isort",
				"jq",
				"json-lsp",
				"jsonlint",
				"lua-language-server",
				"php-cs-fixer",
				"prettier",
				"prettierd",
				"python-lsp-server",
				"rust-analyzer",
				"shellcheck",
				"shellharden",
				"shfmt",
				"standardjs",
				"stylelint",
				"stylelint-lsp",
				"stylua",
				"tailwindcss-language-server",
				"terraform-ls",
				"tflint",
				"typescript-language-server",
				"yaml-language-server",
				"yamlfmt",
				"yamllint",
			}
			local missing_tools = filter_missing_tools(ensure_installed)
			if #missing_tools > 0 then
				vim.cmd('MasonInstall ' .. table.concat(missing_tools, ' '))
			end
		end, { desc = "install lsp tools" })
	end,
}
