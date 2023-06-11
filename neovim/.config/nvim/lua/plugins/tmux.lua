return {
	"aserowy/tmux.nvim",
	config = function()
		local tmux = require("tmux")
		local key = vim.keymap.set
		tmux.setup({
			copy_sync = {
				enable = false,
			},
			navigation = {
				cycle_navigation = false,
				enable_default_keybindings = true,
				persist_zoom = true,
			},
			resize = {
				enable_default_keybindings = false,
			},
		})
		key("n", "<c-left>", tmux.resize_left)
		key("n", "<c-down>", tmux.resize_bottom)
		key("n", "<c-up>", tmux.resize_top)
		key("n", "<c-right>", tmux.resize_right)
	end,
}
