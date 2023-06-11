local util = require 'lspconfig.util'

return function(on_attach)
	return {
		function(attach, capabilities)
			require("lspconfig").bashls.setup({
				on_attach = attach,
				capabilities = capabilities,
				cmd = { 'bash-language-server', 'start' },
				cmd_env = {
					GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zsh)",
				},
				settings = {
					bashIde = {
						globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command|.zsh)',
					},
				},
				filetypes = { "sh", "zsh" },
				root_dir = util.find_git_ancestor,
				single_file_support = true,
			})
		end,
		default_config = {
			docs = {
				description = [[
				https://github.com/bash-lsp/bash-language-server
				`bash-language-server` can be installed via `npm i -g bash-language-server`
				]],
				default_config = {
					root_dir = [[util.find_git_ancestor]],
				},
			},
		}
	}
end
