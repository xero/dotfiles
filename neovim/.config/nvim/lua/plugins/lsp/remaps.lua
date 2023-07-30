local r = require("utils.remaps")
local vim = vim
local X = {}

local function LspToggle()
	if vim.diagnostic.is_disabled(0) == true then
		vim.diagnostic.enable()
		vim.diagnostic.config({ virtual_text = true })
		vim.cmd([[LspStart]])
	else
		vim.diagnostic.disable()
		vim.cmd([[LspStop]])
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

function X.set_default_on_buffer(client, bufnr)
	local buf_set_keymap = generate_buf_keymapper(bufnr)
	local filetype = vim.api.nvim_buf_get_option(bufnr or 0, "filetype")
	-- local is_typescript = filetype == "typescript" or filetype == "typescriptreact"

	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	local cap = client.server_capabilities

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	if cap.definitionProvider then
		buf_set_keymap("n", "gD", vim.lsp.buf.definition, "show definition")
	end

	if cap.declarationProvider then
		buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", "show declaration")
	end

	if cap.implementationProvider then
		buf_set_keymap("n", "gi", vim.lsp.buf.implementation, "go to implementation")
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
		buf_set_keymap("n", "K", vim.lsp.buf.hover, "hover docs")
	end

	if cap.codeActionProvider then
		buf_set_keymap({ "n", "v" }, "<leader>ra", function()
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			--[[ local range = vim.lsp.util.make_given_range_params({ 1, 1 }, { line_count, 1 }, bufnr) ]]
			local range = {
				start = { line = 1, character = 1 },
				["end"] = { line = line_count, character = 1 },
			}

			vim.lsp.buf.code_action({ range = range.range })
		end, "code actions")
	end

	buf_set_keymap("n", "<leader>rf", function()
		if cap.documentFormattingProvider then
			vim.lsp.buf.format({
				async = true,
				bufnr = bufnr,
			})
		else
			require("plugins.lsp.format").run()
		end
	end, "format")

	if cap.renameProvider then
		buf_set_keymap("n", "<leader>rr", ":IncRename ", "rename")
	end

	if cap.documentSymbolProvider then
		buf_set_keymap("n", "<leader>lo", function()
			require("fzf-lua").lsp_document_symbols()
		end, "Document symbols")
	end

	buf_set_keymap("n", "<leader>lsa", ":LspInfo<CR>", "LSP info")
	buf_set_keymap("n", "<leader>ls", vim.lsp.buf.signature_help, "Show signature")
	buf_set_keymap("n", "<leader>lE", function()
		require("fzf-lua").diagnostics_document()
	end, "show diagnostics")

	buf_set_keymap("n", "<leader>le", vim.diagnostic.open_float, "show line diagnostics")

	buf_set_keymap("n", "<leader>lsc", function()
		print(vim.inspect(vim.lsp.get_active_clients()))
	end, "LSP clients")

	buf_set_keymap("n", "<leader>lsl", function()
		print(vim.lsp.get_log_path())
	end, "show log path")

	buf_set_keymap("n", "<leader>lt", function()
		LspToggle()
	end, "toggle LSP")

	buf_set_keymap("n", "<leader>ll", function()
		if vim.diagnostic.is_disabled(0) == true then
			vim.diagnostic.enable()
			vim.cmd([[LspStart]])
		end
		require("lsp_lines").toggle()
		vim.diagnostic.config({ virtual_text = false })
	end, "toggle lsp lines")
end

r.which_key("<leader>ls", "LSP servers")
r.noremap("n", "<leader>lsi", "<cmd>LspInstallInfo<CR>", "LSP servers install info")

return X
