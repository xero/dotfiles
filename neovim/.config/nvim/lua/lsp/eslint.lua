return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.server_capabilities.document_formatting = true
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = bufnr,
				command = 'EslintFixAll',
			})
		end,
		cmd = { "vscode-eslint-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript", "typescriptreact",
			"typescript.tsx",
			"vue",
			"svelte",
			"astro",
			"js",
		},
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine"
			},
			showDocumentation = {
				enable = true
			}
		},
		codeActionOnSave = {
			enable = false,
			mode = "all"
		},
		experimental = {
			useFlatConfig = false
		},
		format = true,
		nodePath = "",
		onIgnoredFiles = "off",
		packageManager = "npm",
		problems = {
			shortenToSingleLine = false
		},
		quiet = false,
		run = "onType",
		useESLintClass = false,
		validate = "on",
		workingDirectory = {
			mode = "location"
		}
	}
end
