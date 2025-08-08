return function(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	return {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas({
					select = {
						"package.json",
						".eslintrc",
						"GitHub Action",
						"prettierrc.json",
					},
				}),
			},
		},
	}
end
