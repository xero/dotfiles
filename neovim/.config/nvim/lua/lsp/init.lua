-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

local remaps = require("lsp.remaps")
local icons = require("utils.icons")
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"b0o/schemastore.nvim",
		"mason-org/mason-lspconfig.nvim",
		"smjonas/inc-rename.nvim",
		"ravibrock/spellwarn.nvim",
		"dgagn/diagflow.nvim",
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.fn.sign_define("DiagnosticSignError", {
			text = icons.diagnostics.error,
			texthl = "DiagnosticSignError",
		})
		vim.fn.sign_define("DiagnosticSignWarn", {
			text = icons.diagnostics.warning,
			texthl = "DiagnosticSignWarn",
		})
		vim.fn.sign_define("DiagnosticSignHint", {
			text = icons.diagnostics.hint,
			texthl = "DiagnosticSignHint",
		})
		vim.fn.sign_define("DiagnosticSignInfo", {
			text = icons.diagnostics.information,
			texthl = "DiagnosticSignInfo",
		})
		vim.lsp.set_log_level("error") -- 'trace', 'debug', 'info', 'warn', 'error'

		-- Global on_attach via autocmd (replaces per-server on_attach)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				remaps.set_default_on_buffer(client, args.buf)
			end,
		})

		local diag_config = {
			virtual_text = false, -- appears after the line
			virtual_lines = false, -- appears under the line
			update_in_insert = false,
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
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
					[vim.diagnostic.severity.WARN] = icons.diagnostics.warning,
					[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
					[vim.diagnostic.severity.INFO] = icons.diagnostics.information,
				},
			},
		}
		vim.diagnostic.config(diag_config)

		local border = { border = "shadow" }
		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, border)
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, border)

		-- Global LSP defaults (replaces lspconfig.util.default_config merge)
		vim.lsp.config("*", {
			capabilities = vim.lsp.protocol.make_client_capabilities(),
			flags = {
				debounce_text_changes = 200,
				allow_incremental_sync = true,
			},
		})

		require("lsp.bashls")
		require("lsp.jsonls")
		local simple_servers = {
			"tailwindcss",
			"ts_ls",
			"dockerls",
			"html",
			"pylsp",
			"rust_analyzer",
			"terraformls",
			"tflint",
			"yamlls",
		}
		vim.lsp.enable(simple_servers)

		local mason_ok, mason = pcall(require, "mason")
		local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
		if mason_ok and mason_lspconfig_ok then
			mason.setup()
			mason_lspconfig.setup({
				ensure_installed = {
					"bashls", "dockerls", "html", "jsonls",
					"lua_ls", "intelephense", "pylsp", "rust_analyzer",
					"tailwindcss", "terraformls", "tflint", "ts_ls", "yamlls",
				},
				automatic_enable = true,
			})
		end

		require("lsp_lines").setup()
		require("inc_rename").setup({
			hl_group = "Substitute",
			preview_empty_name = false,
			show_message = true,
			save_in_cmdline_history = false,
			input_buffer_type = "snacks",
		})
		require("spellwarn").setup()
		require("diagflow").setup({
			enable = true,
			max_width = 60,
			max_height = 10,
			severity_colors = {
				error = "DiagnosticFloatingError",
				warning = "DiagnosticFloatingWarn",
				info = "DiagnosticFloatingInfo",
				hint = "DiagnosticFloatingHint",
			},
			format = function(diagnostic)
				return diagnostic.message
			end,
			gap_size = 1,
			scope = "line", -- cursor/line
			padding_top = 0,
			padding_right = 0,
			text_align = "right",
			placement = "top",
			inline_padding_left = 0,
			toggle_event = {},
			show_sign = true,
			update_event = { "DiagnosticChanged", "BufReadPost" },
			render_event = { "DiagnosticChanged", "CursorMoved" },
			border_chars = icons.borders.diagflow,
			show_borders = true,
		})
	end,
}
