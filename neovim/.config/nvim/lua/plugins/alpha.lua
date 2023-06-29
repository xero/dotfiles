return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	opts = function()
		local dashboard = require('alpha.themes.dashboard')
		require("alpha.term")
		dashboard.section.terminal.command = "cat | " .. vim.fn.stdpath("config") .. "/logo-truecolor.sh"
		dashboard.section.terminal.width = 70
		dashboard.section.terminal.height = 10
		dashboard.section.terminal.opts.redraw = true
		dashboard.section.header.val = ''
		-- stylua: ignore
		dashboard.section.buttons.val = {
			dashboard.button('i', '  new file', ':ene <BAR> startinsert<CR>'),
			dashboard.button('r', '  recent files', ':Telescope oldfiles<CR>'),
			dashboard.button('f', '󰥨  find file', ':Telescope file_browser<CR>'),
			dashboard.button('g', '󰱼  find text', ':Telescope live_grep_args<CR>'),
			dashboard.button('l', '󰒲  lazy', ':Lazy<CR>'),
			dashboard.button('m', '󱌣  mason', ':Mason<CR>'),
			dashboard.button('q', '󰭿  quit', ':qa<CR>'),
		}
		dashboard.opts.layout[1].val = 6 -- padding
		dashboard.opts.layout[3] = dashboard.section.terminal
		return dashboard
	end,
	config = function(_, dashboard)
		-- close lazy and re-open when the dashboard is ready
		if vim.o.filetype == 'lazy' then
			vim.cmd.close()
			vim.api.nvim_create_autocmd('User', {
				pattern = 'AlphaReady',
				callback = function()
					require('lazy').show()
				end,
			})
		end
		require('alpha').setup(dashboard.opts)

		vim.api.nvim_create_autocmd('User', {
			pattern = 'LazyVimStarted',
			callback = function()
				local stats = require('lazy').stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				dashboard.section.footer.val = '⚡ ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
