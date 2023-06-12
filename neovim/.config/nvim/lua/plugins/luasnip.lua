return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	event = "InsertEnter",
	config = function()
		local luasnip = require("luasnip")
		luasnip.config.set_config({
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

		r.map("i", "<c-l>", function()
			if luasnip.choice_active() then
				luasnip.change_choice(1)
			end
		end, "Show list of options")

	end,
}
