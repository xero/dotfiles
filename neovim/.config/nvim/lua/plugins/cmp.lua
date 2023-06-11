return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"windwp/nvim-autopairs",
		"onsails/lspkind-nvim",
		"roobert/tailwindcss-colorizer-cmp.nvim"
	},
	config = function()
		local cmp = require("cmp")
		local lsp_kind = require("lspkind")

		lsp_kind.init()

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = {
				["<C-d>"] = cmp.mapping.scroll_docs( -4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<S-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<tab>"] = function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif require("luasnip").expand_or_jumpable() then
						vim.fn.feedkeys(
						vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true),
						""
						)
					else
						fallback()
					end
				end,
				["<C-p>"] = function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif require("luasnip").jumpable( -1) then
						vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
					else
						fallback()
					end
				end,
			},
			formatting = {
				format = function(entry, vim_item)
					-- fancy icons and a name of kind
					vim_item.kind = lsp_kind.presets.default[vim_item.kind] .. " " .. vim_item.kind

					-- set a name for each source
					vim_item.menu = ({
						-- copilot = "[cop]",
						nvim_lsp = "[LSP]",
						luasnip = "[snp]",
						buffer = "[buf]",
						nvim_lua = "[lua]",
						path = "[path]",
					})[entry.source.name]

					return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
				end,
			},
			sources = {
				-- { name = "copilot", priority = 1, group_index = 1 },
				{ name = "nvim_lsp_signature_help", group_index = 1 },
				{ name = "luasnip",                 max_item_count = 5,  group_index = 1 },
				{ name = "nvim_lsp",                max_item_count = 20, group_index = 1 },
				{ name = "nvim_lua",                group_index = 1 },
				{ name = "path",                    group_index = 2 },
				{ name = "buffer",                  keyword_length = 2,  max_item_count = 5, group_index = 2 },
			},
			experimental = { native_menu = false, ghost_text = false },
		})

		local presentAutopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
		if not presentAutopairs then
			return
		end

		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
	end,
}
