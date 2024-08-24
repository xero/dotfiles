return {
	"terrortylor/nvim-comment",
	event = "BufReadPost",
	config = function()
		require("nvim_comment").setup({
			line_mapping = "gl",
		})
		require("utils.remaps").map_virtual({
			{ "<leader>g", group = "go", icon = { icon = "󰮱 ", hl = "Constant" } },
			{ "g", group = "go", icon = { icon = "󰮱 ", hl = "Constant" } },
			{ "gc", group = "comment", icon = { icon = "󱗟 ", hl = "Constant" } },
			{ "gc", mode = "v", group = "comment", icon = { icon = "󱗟 ", hl = "Constant" } },
			{ "gl", desc = "comment line", icon = { icon = "󱗟 ", hl = "Constant" } },
		})
	end,
}
