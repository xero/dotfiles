local icons = require("utils.icons")
return {
	{
		"saghen/blink.cmp",
		lazy = false,
		version = "1.*",
		opts = {
			appearance = {
				kind_icons = icons.trouble.kinds,
			},
			keymap = {
				preset = "none",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<Up>"] = { "scroll_documentation_up", "fallback" },
				["<Down>"] = { "scroll_documentation_down", "fallback" },
				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},
			cmdline = {
				completion = {
					list = { selection = { preselect = false } },
					menu = { auto_show = true },
				},
			},
			completion = {
				menu = {
					border = "rounded",
					direction_priority = { "n", "s" },
					draw = { treesitter = { "lsp" } },
				},
				documentation = {
					auto_show = true,
					window = { border = "rounded" },
				},
				trigger = {
					show_on_keyword = true,
					show_on_accept_on_trigger_character = true,
					show_on_insert_on_trigger_character = true,
					show_on_trigger_character = true,
					show_on_blocked_trigger_characters = { " ", "\n", "\t" },
				},
				ghost_text = { enabled = false },
				list = { selection = { preselect = false } },
			},
			fuzzy = {
				implementation = "prefer_rust",
				sorts = {
					"exact",
					"score",
					"sort_text",
				},
			},
			signature = {
				enabled = true,
				trigger = { show_on_insert = true },
				window = {
					border = "rounded",
					direction_priority = { "s", "n" },
					show_documentation = true,
				},
			},
			snippets = { preset = "luasnip" },
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer", "dadbod" },
				providers = {
					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						min_keyword_length = 2,
						score_offset = 65, -- the higher the number, the higher the priority
						transform_items = function(a, items)
							local keyword = a.get_keyword()
							local correct, case
							if keyword:match("^%l") then
								correct = "^%u%l+$"
								case = string.lower
							elseif keyword:match("^%u") then
								correct = "^%l+$"
								case = string.upper
							else
								return items
							end

							-- avoid duplicates from the corrections
							local seen = {}
							local out = {}
							for _, item in ipairs(items) do
								local raw = item.insertText
								if raw and raw:match(correct) then
									local text = case(raw:sub(1, 1)) .. raw:sub(2)
									item.insertText = text
									item.label = text
								end
								if not seen[item.insertText] then
									seen[item.insertText] = true
									table.insert(out, item)
								end
							end
							return out
						end,
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 70,
						min_keyword_length = 2,
						fallbacks = { "snippets", "buffer" },
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						min_keyword_length = 2,
						score_offset = 85,
					},
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
						min_keyword_length = 2,
						score_offset = 80,
					},
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						score_offset = 95,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		event = "InsertEnter",
		postinstall = "make install_jsregexp",
		config = function()
			local luasnip = require("luasnip")
			luasnip.setup({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
			-- add vscode exported completions
			require("luasnip.loaders.from_vscode").lazy_load()
			local r = require("utils.remaps")

			r.map({ "i", "s" }, "<c-n>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				end
			end, "Expand current snippet or jump to next", { silent = true })

			r.map({ "i", "s" }, "<c-p>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
			end, "Go to previous snippet", { silent = true })
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
}
