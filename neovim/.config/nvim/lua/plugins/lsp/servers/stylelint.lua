local util = require 'lspconfig.util'
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
		settings = {
			stylelintplus = {
				autoFixOnSave = true,
				autoFixOnFormat = true,
				validateOnSave = false,
				validateOnType = true,
			}
		},
		filetypes = { "css", "less", "scss", "sugarss", "vue", "wxss" },
		root_dir = util.find_git_ancestor,
		single_file_support = true,
	}
end
