local function fix_all(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or vim.api.nvim_get_current_buf()
	vim.validate("bufnr", bufnr, "number")
	local client = opts.client or vim.lsp.get_clients({ bufnr = bufnr, name = "eslint" })[1]
	if not client then return end
	local request
	if opts.sync then
		request = function(buf, method, params)
			client:request_sync(method, params, nil, buf)
		end
	else
		request = function(buf, method, params)
			client:request(method, params, nil, buf)
		end
	end
	request(bufnr, "workspace/executeCommand", {
		command = "eslint.applyAllFixes",
		arguments = { {
			uri = vim.uri_from_bufnr(bufnr),
			version = vim.lsp.util.buf_versions[bufnr],
		} }
	})
end
return function()
	vim.lsp.config("eslint", {
		on_init = function(client)
			vim.api.nvim_create_user_command("EslintFixAll", function()
				fix_all({ client = client, sync = true })
			end, {})
		end,
		on_attach = function(client, _)
			client.server_capabilities.document_formatting = true
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("eslint_fix", { clear = true }),
				pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
				command = "silent! EslintFixAll",
			})
		end,
		settings = {
			experimental = {
				useFlatConfig = true,
			},
			format = true,
			run = "onType",
			validate = "on",
			workingDirectory = { mode = "location" },
			problems = { shortenToSingleLine = false },
			quiet = false,
		},
	})
	vim.lsp.enable("eslint")
end
