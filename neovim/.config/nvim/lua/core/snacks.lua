---@diagnostic disable undefined global
local i = require("utils.icons")
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		dim = { enabled = false },
		scroll = { enabled = vim.g.neovide == true },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		explorer = { enabled = false },
		quickfile = { enabled = true },
		input = { enabled = true },
		picker = { enabled = true },
		animate = { enabled = true },
		notifier = {
			enabled = true,
			timeout = 3000,
		},
		indent = {
			indent = {
				enabled = true,
				char = i.snacks.chunk.vertical,
				only_scope = false,
				only_current = false,
			},
			scope = {
				enabled = true,
				char = i.snacks.chunk.vertical,
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
				char = i.snacks.chunk,
			},
		},
		bigfile = {
			enabled = true,
			notify = true,
			size = 1.5 * 1024 * 1024, -- 1.5MB
			line_length = 1000,
			---@param ctx {buf: number, ft:string}
			setup = function(ctx)
				if vim.fn.exists(":MatchParenDisable") ~= 0 then
					vim.cmd([[MatchParenDisable]])
				end
				vim.opt_local.swapfile = false
				vim.opt_local.foldmethod = "manual"
				vim.opt_local.undolevels = -1
				vim.opt_local.undoreload = 0
				vim.opt_local.list = false
				vim.cmd("syntax clear")
				vim.opt_local.syntax = "off"
				vim.opt_local.filetype = ""
				vim.diagnostic.enable(false)
				if vim.fn.exists(":VimadeDisable") ~= 0 then
					vim.cmd([[VimadeDisable]])
				end
				vim.cmd("TSDisable highlight")
				vim.cmd("TSDisable incremental_selection")
				vim.cmd("TSDisable indent")
				vim.cmd("TSDisable textobjects.lsp_interop")
				vim.cmd("TSDisable textobjects.move")
				vim.cmd("TSDisable textobjects.select")
				vim.cmd("TSDisable textobjects.swap")
				require("lualine").hide()
				for _, client in pairs(vim.lsp.get_clients()) do
					client.stop()
				end
				vim.api.nvim_create_autocmd({ "LspAttach" }, {
					buffer = buf,
					callback = function(args)
						vim.schedule(function()
							vim.lsp.buf_detach_client(buf, args.data.client_id)
						end)
					end,
				})
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
		dashboard = {
			preset = {
				keys = function()
					local colors = require("evangelion.unit01").get()
					vim.api.nvim_set_hl(0, "SnacksDashboardIcon", { fg = colors.dummyplug })
					vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = colors.adam })
					vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = colors.kaworu, bg = colors.melchior, bold = true })
					vim.api.nvim_set_hl(0, "SnacksDashboardFooter", { fg = colors.lcl, bold = true })
					vim.api.nvim_set_hl(0, "SnacksDashboardSpecial", { fg = colors.penpen, bg = colors.melchior, bold = true })
					vim.api.nvim_set_hl(0, "SnacksDashboardFade", { fg = colors.melchior })
					return { {
							text = {
								{ "           " .. i.snacks.new .. "  ", hl = "SnacksDashboardIcon" },
								{ "new file", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " i ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":ene | startinsert",
							key = "i",
						}, {
							text = {
								{ "           " .. i.snacks.old .. "  ", hl = "SnacksDashboardIcon" },
								{ "old files", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " o ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Telescope oldfiles",
							key = "o",
						}, {
							text = {
								{ "           " .. i.snacks.findf .. "  ", hl = "SnacksDashboardIcon" },
								{ "find file", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " f ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Telescope file_browser",
							key = "f",
						}, {
							text = {
								{ "           " .. i.snacks.findt .. "  ", hl = "SnacksDashboardIcon" },
								{ "find text", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " \\ ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":LiveGrep",
							key = "\\",
						}, {
							text = {
								{ "           " .. i.snacks.git .. "  ", hl = "SnacksDashboardIcon" },
								{ "browse git", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " g ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Flog",
							key = "g",
						}, {
							text = {
								{ "           " .. i.snacks.lazy .. "  ", hl = "SnacksDashboardIcon" },
								{ "lazy", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " l ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Lazy",
							key = "l",
						}, {
							text = {
								{ "           " .. i.snacks.mason .. "  ", hl = "SnacksDashboardIcon" },
								{ "mason", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " m ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Mason",
							key = "m",
						}, {
							text = {
								{ "           " .. i.snacks.prof .. "  ", hl = "SnacksDashboardIcon" },
								{ "profile", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " p ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":Lazy profile",
							key = "p",
						}, {
							text = {
								{ "           " .. i.snacks.quit .. "  ", hl = "SnacksDashboardIcon" },
								{ "quit", hl = "SnacksDashboardDesc", width = 45 },
								{ "░▒▓", hl = "SnacksDashboardFade" },
								{ " q ", hl = "SnacksDashboardKey" },
								{ "▓▒░", hl = "SnacksDashboardFade" },
							},
							action = ":qa",
							key = "q",
						},
					}
				end,
			},
			sections = {
				{
					section = "terminal",
					cmd = "~/.config/nvim/lua/ui/nvim-logo -e",
					height = 9,
					width = 70,
					padding = 2,
				},
				-- {
				-- 	section = "terminal",
				-- 	cmd = "~/.config/nvim/lua/ui/eva-logo -cc",
				-- 	height = 14,
				-- 	width = 66,
				-- 	padding = 1,
				-- },
				{
					section = "keys",
					gap = 0,
					padding = 2,
				},
				{
					section = "startup",
					icon = "         " .. i.snacks.plug .. " ",
					padding = 0,
					gap = 0,
				},
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- force refresh req'd
				Snacks.dashboard.update()

				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				-- Override print to use snacks for `:=` command
				-- :=Snacks.notifier.notify("hello",4)
				vim.print = _G.dd

				local r = require("utils.remaps")
				r.map_virtual({
					{
					"<leader>U",
					group = "snacks",
					icon = { icon = i.snacks.snack, hl = "Constant" },
					},{
					"<leader>Um",
					group = "message history",
					icon = { icon = i.snacks.msgs, hl = "Constant" },
					}
				})
				r.noremap("n", "<leader>Um", function()
					Snacks.notifier.show_history()
				end, "message history")
				r.noremap("n", "<leader>UU", function()
					Snacks.picker.undo()
				end, "undo tree")
				Snacks.toggle.option("conceallevel", {
					off = 0,
					on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
				}):map("<leader>Uc")
				Snacks.toggle.option("spell", { name = "Spelling" })
					:map("<leader>s")
				Snacks.toggle.option("wrap", { name = "Wrap" })
					:map("<leader>w")
				Snacks.toggle.option("relativenumber", { name = "Relative Number" })
					:map("<leader>UL")
				Snacks.toggle.diagnostics()
					:map("<leader>Ud")
				Snacks.toggle.line_number()
					:map("<leader>Ul")
				Snacks.toggle.treesitter()
					:map("<leader>UT")
				Snacks.toggle.inlay_hints()
					:map("<leader>Uh")
				Snacks.toggle.indent()
					:map("<leader>Ug")
			end,
		})
	end,
}
