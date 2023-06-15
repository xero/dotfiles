local util = require 'lspconfig.util'
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.document_formatting = true
		end,
		cmd = { 'bash-language-server', 'start' },
		cmd_env = {
			GLOB_PATTERN = "*@(.sh|.inc|.bash|.command|.zsh)",
		},
		settings = {
			bashIde = {
				globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command|.zsh)',
			},
			format = { enable = true },
		},
		filetypes = { "sh", "zsh" },
		root_dir = util.find_git_ancestor,
		single_file_support = true,
	}
end
