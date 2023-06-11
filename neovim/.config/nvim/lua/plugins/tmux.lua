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
		local zoom = function()
			if vim.fn.winnr('$') > 1 then
				if vim.g.zoomed ~= nil then
					vim.cmd(vim.g.zoom_winrestcmd)
					vim.g.zoomed = 0
				else
					vim.g.zoom_winrestcmd = vim.fn.winrestcmd()
					vim.cmd('resize')
					vim.cmd('vertical resize')
					vim.g.zoomed = 1
				end
			else
				vim.cmd("!tmux resize-pane -Z")
			end
		end
		key("n", "<c-left>", tmux.resize_left)
		key("n", "<c-down>", tmux.resize_bottom)
		key("n", "<c-up>", tmux.resize_top)
		key("n", "<c-right>", tmux.resize_right)
		key("n", "<leader>z", zoom)
	end,
}
