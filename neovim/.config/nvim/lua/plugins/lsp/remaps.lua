local r = require("utils.remaps")
local vim = vim
local X = {}

local function LspToggle()
	if vim.diagnostic.is_enabled() == false then
		vim.diagnostic.enable()
		vim.diagnostic.config({ virtual_text = true })
		vim.cmd([[LspStart]])
		print(" lsp starting...")
	else
		vim.diagnostic.enable(false)
		vim.cmd([[LspStop]])
		print("lsp disabled")
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

	local function buf_set_option(o, v)
		vim.api.nvim_set_option_value(o, v, { buf = bufnr })
	end

	local cap = client.server_capabilities

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	if cap.definitionProvider then
		buf_set_keymap("n", "<leader>lD", vim.lsp.buf.definition, "show definition")
	end

	if cap.declarationProvider then
		buf_set_keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<CR>", "show declaration")
	end

	if cap.implementationProvider then
		buf_set_keymap("n", "gi", vim.lsp.buf.implementation, "go to implementation")
		buf_set_keymap("n", "gI", function()
			require("fzf-lua").lsp_implementations()
		end, "search implementations")
	end

	if cap.referencesProvider then
		buf_set_keymap("n", "<leader>/lr", function()
			require("fzf-lua").lsp_references()
		end, "show references")
	end

	if cap.hoverProvider then
		buf_set_keymap("n", "K", vim.lsp.buf.hover, "hover docs")
	end

	if cap.codeActionProvider then
		buf_set_keymap({ "n", "v" }, "<leader>ra", function()
			local line_count = vim.api.nvim_buf_line_count(bufnr)
			local range = {
				start = { line = 1, character = 1 },
				["end"] = { line = line_count, character = 1 },
			}
			vim.lsp.buf.code_action({ range = range.range })
		end, "code actions")
	end

	if cap.renameProvider then
		buf_set_keymap("n", "<leader>rr", ":IncRename ", "rename")
	end

	if cap.documentSymbolProvider then
		buf_set_keymap("n", "<leader>lo", function()
			require("fzf-lua").lsp_document_symbols()
		end, "document symbols")
	end

	local ft = vim.bo[bufnr].filetype
	if ft == "sh" or ft == "lua" then
		buf_set_keymap("n", "<leader>li", function()
			local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
			local msgs = vim.diagnostic.get(bufnr)
			local last, result = unpack({ "error", "" })
			if ft == "lua" then
				result = "---@diagnostic disable-next-line"
			else
				for _, d in pairs(msgs) do
					if d.lnum == (row - 1) and d.code ~= last then
						result = (result ~= "") and result .. "," .. d.code or "#shellcheck disable=" .. d.code
						last = tostring(d.code)
					end
				end
			end
			if result ~= "" then
				vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { result })
			end
		end, "ignore warnings")
	end

	buf_set_keymap("n", "<leader>lI", ":LspInfo<CR>", "lsp info")
	buf_set_keymap("n", "<leader>ls", vim.lsp.buf.signature_help, "show signature")
	buf_set_keymap("n", "<leader>lE", vim.diagnostic.open_float, "show line diagnostics")
	buf_set_keymap("n", "<leader>lt", function()
		LspToggle()
	end, "toggle lsp")
	buf_set_keymap("n", "<leader>ll", function()
		if vim.diagnostic.is_enabled() == false then
			vim.diagnostic.enable()
			vim.cmd([[LspStart]])
		end
		require("lsp_lines").toggle()
	end, "toggle lsp lines")
	r.map_virtual({
		{ "<leader>l", group = "lsp", icon = { icon = "", hl = "Constant" } },
		{ "<leader>ll", group = "lsp lines", icon = { icon = "󱞽", hl = "Constant" } },
		{ "<leader>lI", group = "lsp Info", icon = { icon = "", hl = "Constant" } },
		{ "<leader>ls", group = "show signature", icon = { icon = "󰅨", hl = "Constant" } },
		{ "<leader>lE", group = "show line diagnostics", icon = { icon = "󰅰", hl = "Constant" } },
		{ "<leader>lD", group = "show definition", icon = { icon = "", hl = "Constant" } },
		{ "<leader>/lr", group = "show references", icon = { icon = "", hl = "Constant" } },
		{ "<leader>ra", group = "code actions (range)", icon = { icon = "", hl = "Constant" } },
		{ "<leader>rr", group = "rename", icon = { icon = "", hl = "Constant" } },
		{ "<leader>li", group = "ignore warning", icon = { icon = "", hl = "Constant" } },
		{ "<leader>lo", group = "document symbols", icon = { icon = "", hl = "Constant" } },
		{ "<leader>ld", group = "show declaration", icon = { icon = "", hl = "Constant" } },
		{ "<leader>lt", group = "toggle lsp", icon = { icon = "", hl = "Constant" } },
	})
end

return X
