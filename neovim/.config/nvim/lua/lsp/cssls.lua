local util = require 'lspconfig.util'
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
		settings = {
			css = {
				validate = true,
				lint = {
					unknownAtRules = "ignore"
				}
			},
			scss = {
				validate = true,
				lint = {
					unknownAtRules = "ignore"
				}
			},
			less = {
				validate = true,
				lint = {
					unknownAtRules = "ignore"
				}
			},
		},
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss" },
		root_dir = util.find_git_ancestor,
		single_file_support = true,
	}
end
