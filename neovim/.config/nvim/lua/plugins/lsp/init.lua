return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/neodev.nvim",
		"b0o/schemastore.nvim",
		"ravibrock/spellwarn.nvim",
		"williamboman/mason-lspconfig.nvim",
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("neodev").setup({})
		require("lsp_lines").setup()
		require("spellwarn").setup()
		local lspconfig = require("lspconfig")
		local remaps = require("plugins.lsp.remaps")
		local icons = require("utils.icons")

		local presentCmpNvimLsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		local presentLspSignature, lsp_signature = pcall(require, "lsp_signature")

		vim.lsp.set_log_level("error")

		local function on_attach(client, bufnr)
			remaps.set_default_on_buffer(client, bufnr)
			if presentLspSignature then
				lsp_signature.on_attach({ floating_window = false, timer_interval = 500 })
			end
		end

		local signs = {
			{ name = "DiagnosticSignError", text = icons.diagnostics.error },
			{ name = "DiagnosticSignWarn", text = icons.diagnostics.warning },
			{ name = "DiagnosticSignHint", text = icons.diagnostics.hint },
			{ name = "DiagnosticSignInfo", text = icons.diagnostics.information },
		}
		for _, sign in ipairs(signs) do
			vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
		end

		local config = {
			virtual_text = false, -- appears after the line
			virtual_lines = false, -- appears under the line
			signs = {
				active = signs,
			},
			flags = {
				debounce_text_changes = 200,
			},
			update_in_insert = true,
			underline = true,
			severity_sort = true,
			float = {
				focus = false,
				focusable = false,
				style = "minimal",
				border = "shadow",
				source = "always",
				header = "",
				prefix = "",
			},
		}
		lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, config)
		vim.diagnostic.config(config)

		local border = {
			border = "shadow",
		}
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, border)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)

		local capabilities
		if presentCmpNvimLsp then
			capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
		else
			capabilities = vim.lsp.protocol.make_client_capabilities()
		end

		local servers = {
			bashls = require("plugins.lsp.servers.bashls")(on_attach),
			cssls = require("plugins.lsp.servers.cssls")(on_attach),
			dockerls = {},
			html = {},
			jsonls = {},
			lua_ls = require("plugins.lsp.servers.luals")(on_attach),
			intelephense = require("plugins.lsp.servers.phpls")(on_attach),
			pylsp = {},
			rust_analyzer = {},
			tailwindcss = require("plugins.lsp.servers.tailwindcss")(on_attach),
			terraformls = {},
			tflint = {},
			ts_ls = require("plugins.lsp.servers.ts_ls")(on_attach),
			yamlls = {},
		}

		local default_lsp_config = {
			on_attach = on_attach,
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 200,
				allow_incremental_sync = true,
			},
		}

		local server_names = {}
		local server_configs = {}
		for server_name, server_config in pairs(servers) do
			table.insert(server_names, server_name)
			server_configs[server_name] = server_config
		end

		local present_mason, mason = pcall(require, "mason-lspconfig")
		if present_mason then
			mason.setup({ ensure_installed = server_names })
			mason.setup_handlers({
				function(server)
					local merged_config = vim.tbl_deep_extend("force", default_lsp_config, server_configs[server] or {})
					lspconfig[server].setup(merged_config)
					if server == "rust_analyzer" then
						local present_rust_tools, rust_tools = pcall(require, "rust-tools")
						if present_rust_tools then
							rust_tools.setup({ server = merged_config })
						end
					end
				end,
			})
		end
	end,
}
