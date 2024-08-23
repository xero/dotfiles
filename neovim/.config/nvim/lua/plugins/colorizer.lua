return {
	"brenoprata10/nvim-highlight-colors",
	event = "VeryLazy",
	config = function()
		local r = require("utils.remaps")
		local c = require("nvim-highlight-colors")
		c.setup({})
		r.noremap("n", "<leader>c", function()
			c.toggle()
		end, "toggle colorizer")
	end,
}
