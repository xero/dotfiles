-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

return function(capabilities)
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	return {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas({
					select = {
						"package.json",
						".eslintrc",
						"prettierrc.json",
					},
				}),
			},
		},
	}
end
