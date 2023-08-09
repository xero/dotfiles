return {
	"petertriho/nvim-scrollbar",
	event = "VeryLazy",
	config = function()
		local scrollbar = require("scrollbar")
		scrollbar.setup({
			show_in_active_only = true,
			handle = {
				blend = 0,
				text = " ",
				color = "#1c1c1c",
				color_nr = 234,
			},
			marks = {
				Search = { color = "#C9A554" },
				Error  = { color = "#685742" },
				Warn   = { color = "#B36D43" },
				Info   = { color = "#5f875f" },
				Hint   = { color = "#5f875f" },
				Misc   = { color = "#bb7744" },
				Cursor = { color = "#222222" , text = " " },
			}
		})
	end,
}
