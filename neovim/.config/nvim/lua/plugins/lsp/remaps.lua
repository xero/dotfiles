local r = require("utils.remaps")
local vim = vim
local M = {}

local function LspToggle()
	if (vim.diagnostic.is_disabled(0) == true) then
		vim.diagnostic.enable()
		vim.diagnostic.config({ virtual_text = true })
		vim.cmd [[LspStart]]
	else
		vim.diagnostic.disable()
		vim.cmd [[LspStop]]
	end
end

local function generate_buf_keymapper(bufnr)
	return function(type, input, output, description, extraOptions)
		local options = { buffer = bufnr }
		if extraOptions ~= nil then
			options = vim.tbl_deep_extend("force", options, extraOptions)
		end
		r.noremap(type, input, output, description, options)
	end
end

function M.set_default_on_buffer(client, bufnr)
	local buf_set_keymap = generate_buf_keymapper(bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr or 0, "filetype")
	local is_typescript = filetype == "typescript" or filetype == "typescriptreact"

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local cap = client.server_capabilities

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	if cap.definitionProvider then
		buf_set_keymap("n", "gd", vim.lsp.buf.definition, "Preview definition")
	end
	-- if cap.declarationProvider then
	-- map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- end
	if cap.implementationProvider then
		buf_set_keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
		buf_set_keymap("n", "gI", function()
			require("fzf-lua").lsp_implementations()
		end, "Search implementations")
	end

	if cap.referencesProvider then
		buf_set_keymap("n", "gr", function()
			require("fzf-lua").lsp_references()
		end, "Show references")
	end

	if cap.hoverProvider then
		buf_set_keymap("n", "K", vim.lsp.buf.hover, "Hover documentation")
	end

	if cap.documentSymbolProvider then
		buf_set_keymap("n", "<leader>lO", function()
			require("fzf-lua").lsp_document_symbols()
		end, "Document symbols")
	end

	buf_set_keymap("n", "<leader>ls", vim.lsp.buf.signature_help, "Show signature")
	buf_set_keymap("n", "<leader>le", function()
		require("fzf-lua").diagnostics_document()
	end, "Show diagnostics")
	buf_set_keymap("n", "<leader>lE", vim.diagnostic.open_float, "Show line diagnostics")

	-- if cap.workspaceSymbolProvider then
	--   map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
	-- end

	if cap.codeActionProvider then
		buf_set_keymap({ "n", "v" }, "<leader>ra", function()
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			--[[ local range = vim.lsp.util.make_given_range_params({ 1, 1 }, { line_count, 1 }, bufnr) ]]
			local range = {
				start = { line = 1, character = 1 },
				["end"] = { line = line_count, character = 1 },
			}

			vim.lsp.buf.code_action({ range = range.range })
		end, "Buffer code actions")
	end

	-- when sumneko lua will be able to format we can reput the capabilities
	-- if cap.documentFormattingProvider then
	buf_set_keymap("n", "<leader>rf", function()
		vim.lsp.buf.format({
			async = true,
			bufnr = bufnr,
			filter = function(format_client)
				if is_typescript then
					if format_client.name == "null-ls" then
						return true
					else
						return false
					end
				end
				return true
			end,
		})
	end, "Format")
	-- elseif cap.documentRangeFormattingProvider then
	-- buf_set_keymap("n", "<leader>tf", vim.lsp.buf.formatting, "lsp_range_format", "Format")
	-- end

	r.which_key("<leader>ri", "import")

--	if is_typescript then
--		buf_set_keymap("n", "<leader>rio", function()
--			local typescript = require("typescript")
--			typescript.actions.organizeImports()
--		end, "Organize imports (TS)")
--
--		buf_set_keymap("n", "<leader>riu", function()
--			local typescript = require("typescript")
--			typescript.actions.removeUnused()
--		end, "Remove unused variables (TS)")
--
--		buf_set_keymap("n", "<leader>rim", function()
--			local typescript = require("typescript")
--			typescript.actions.addMissingImports()
--		end, "Import all (TS)")
--	end

	if cap.renameProvider then
		buf_set_keymap("n", "<leader>rr", ":IncRename ", "Rename")
	end

	buf_set_keymap("n", "<leader>lsc", function()
		print(vim.inspect(vim.lsp.get_active_clients()))
	end, "LSP clients")

	buf_set_keymap("n", "<leader>lsl", function()
		print(vim.lsp.get_log_path())
	end, "Show log path")

	buf_set_keymap("n", "<leader>lsa", ":LspInfo()<CR>", "LSP Info")

	buf_set_keymap("n", "<leader>lt", function()
		LspToggle()
	end, "toggle LSP")

	buf_set_keymap("n", "<leader>ll", function()
		if (vim.diagnostic.is_disabled(0) == true) then
			vim.diagnostic.enable()
			vim.cmd [[LspStart]]
		end
		require("lsp_lines").toggle()
		vim.diagnostic.config({ virtual_text = false })
	end, "toggle lsp lines")
end

r.which_key("<leader>ls", "LSP servers")
r.noremap("n", "<leader>lsi", "<cmd>LspInstallInfo<CR>", "LSP servers install info")

return M
