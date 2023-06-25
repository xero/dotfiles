return {
	"aserowy/tmux.nvim",
	event = "VeryLazy",
	config = function()
		local tmux = require("tmux")
		local r = require("utils.remaps")
		tmux.setup({
			copy_sync = {
				enable = false,
			},
			navigation = {
				cycle_navigation = false,
				enable_default_keybindings = false,
				persist_zoom = true,
			},
			resize = {
				enable_default_keybindings = false,
			},
		})
		local zoom = function()
			if vim.fn.winnr("$") > 1 then
				if vim.g.zoomed ~= nil then
					vim.cmd(vim.g.zoom_winrestcmd)
					vim.g.zoomed = 0
				else
					vim.g.zoom_winrestcmd = vim.fn.winrestcmd()
					vim.cmd("resize")
					vim.cmd("vertical resize")
					vim.g.zoomed = 1
				end
			else
				vim.cmd("!tmux resize-pane -Z")
			end
		end
		r.noremap("n", "<c-h>", tmux.move_left, "tmux focus left")
		r.noremap("n", "<c-j>", tmux.move_bottom, "tmux focus bottom")
		r.noremap("n", "<c-k>", tmux.move_top, "tmux focus top")
		r.noremap("n", "<c-l>", tmux.move_right, "tmux focus right")
		r.noremap("n", "<c-left>", tmux.resize_left, "tmux resize left")
		r.noremap("n", "<c-down>", tmux.resize_bottom, "tmux resize bottom")
		r.noremap("n", "<c-up>", tmux.resize_top, "tmux resize top")
		r.noremap("n", "<c-right>", tmux.resize_right, "tmux resize right")
		r.noremap("t", "<c-h>", tmux.move_left, "tmux focus left")
		r.noremap("t", "<c-j>", tmux.move_bottom, "tmux focus bottom")
		r.noremap("t", "<c-k>", tmux.move_top, "tmux focus top")
		r.noremap("t", "<c-l>", tmux.move_right, "tmux focus right")
		r.noremap("t", "<c-left>", tmux.resize_left, "tmux resize left")
		r.noremap("t", "<c-down>", tmux.resize_bottom, "tmux resize bottom")
		r.noremap("t", "<c-up>", tmux.resize_top, "tmux resize top")
		r.noremap("t", "<c-right>", tmux.resize_right, "tmux resize right")
		r.noremap("n", "<leader>z", zoom, "tmux zoom")
	end,
}
