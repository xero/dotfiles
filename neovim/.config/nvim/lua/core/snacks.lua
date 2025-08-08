---@diagnostic disable undefined global
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		indent = {
			indent = {
				enabled = true,
				char = "┊",
				only_scope = false,
				only_current = false,
			},
			scope = {
				enabled = true,
				char = "┊",
				underline = false,
				hl = "IblScope",
			},
			animate = {
				enabled = vim.fn.has("nvim-0.10") == 1,
				style = "out",
				easing = "linear",
				duration = {
					step = 20,
					total = 300,
				},
			},
			chunk = {
				enabled = true,
				only_current = false,
				hl = "@comment.note",
				char = {
					corner_top = "┌",
					corner_bottom = "└",
					horizontal = "┄",
					vertical = "┊",
					arrow = "┄",
				},
			},
		},
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		input = { enabled = true },
		picker = { enabled = true },
		animate = { enabled = true },
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5MB
			line_length = 1000,
			-- Enable or disable features when big file detected
			---@param ctx {buf: number, ft:string}
			setup = function(ctx)
				if vim.fn.exists(":NoMatchParen") ~= 0 then
					vim.cmd([[NoMatchParen]])
				end

				vim.diagnostic.enable(false)
				for _, client in pairs(vim.lsp.get_clients()) do
					client.stop()
				end
				local ok, blink_cmp = pcall(require, "blink.cmp")
				if ok then
					blink_cmp.hide()
					blink_cmp.cancel()
				end
				vim.api.nvim_buf_set_option(0, "omnifunc", "")

				Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
				vim.b.minianimate_disable = true
				vim.schedule(function()
					if vim.api.nvim_buf_is_valid(ctx.buf) then
						vim.bo[ctx.buf].syntax = ctx.ft
					end
				end)
			end,
		},
		quickfile = { enabled = true },
		explorer = { enabled = false },
		dashboard = {
			preset = {
				keys = function()
					return {
						{ icon = "         ", key = "i", desc = "new file", action = ":ene | startinsert" },
						{ icon = "         ", key = "o", desc = "old files", action = ":Telescope oldfiles" },
						{ icon = "        󰥨 ", key = "f", desc = "find File", action = ":Telescope file_browser" },
						{ icon = "         ", key = "g", desc = "find text", action = ":lua Snacks.dashboard.pick('live_grep')", },
						{ icon = "         ", key = "h", desc = "browse git", action = ":Flog" },
						{ icon = "        󰒲 ", key = "l", desc = "lazy", action = ":Lazy" },
						{ icon = "        󱌣 ", key = "m", desc = "mason", action = ":Mason" },
						{ icon = "        󰄉 ", key = "p", desc = "profile", action = ":Lazy profile" },
						{ icon = "        󰭿 ", key = "q", desc = "quit", action = ":qa" },
					}
				end,
			},
			sections = {
				{
					section = "terminal",
					cmd = "~/.config/nvim/lua/ui/nvim-logo -l",
					height = 10,
					width = 70,
					padding = 1,
				},
				{ section = "keys", gap = 0, padding = 0 },
			},
		},
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		---@class snacks.dim.Config
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				local r = require("utils.remaps")
				r.map_virtual({ "<leader>U", group = "snacks", icon = { icon = "󰉚 ", hl = "Constant" } })
				r.noremap("n", "<leader>UU", function() Snacks.picker.undo() end, "undo tree")
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>s")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>w")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>UL")
				Snacks.toggle.diagnostics():map("<leader>Ud")
				Snacks.toggle.line_number():map("<leader>Ul")
				Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }) :map("<leader>Uc")
				Snacks.toggle.treesitter():map("<leader>UT")
				Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }) :map("<leader>Ub")
				Snacks.toggle.inlay_hints():map("<leader>Uh")
				Snacks.toggle.indent():map("<leader>Ug")
			end,
		})
	end,
}
