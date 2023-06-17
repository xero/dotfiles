return {
	"levouh/tint.nvim",
	config = function()
		require("tint").setup({
			transforms = {
				require("tint.transforms").tint_with_threshold(-10, "#1a1a1a", 7),
				require("tint.transforms").saturate(0.75),
			},
			tint_background_colors = true,
			highlight_ignore_patterns = { "SignColumn", "LineNr", "CursorLine", "WinSeparator", "Status.*" },
		})
	end,
}
