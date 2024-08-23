return {
	"terrortylor/nvim-comment",
	event = "BufReadPost",
	config = function()
		require("nvim_comment").setup()
		require("which-key").add({
			{ "<leader>g", group = "go", icon = { icon = "󰮱 ", hl = "Constant" } },
			{ "g", group = "go", icon = { icon = "󰮱 ", hl = "Constant" } },
			{ "gc", group = "comment", icon = { icon = "󱗟 ", hl = "Constant" } },
			{ "gc", mode = "v", group = "comment", icon = { icon = "󱗟 ", hl = "Constant" } },
			{ "gcc", desc = "comment line", icon = { icon = "󱗟 ", hl = "Constant" } },
		})
	end,
}
