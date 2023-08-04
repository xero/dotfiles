return {
	'goolord/alpha-nvim',
	event = 'VimEnter',
	opts = function()
		local dashboard = require('alpha.themes.dashboard')
		require("alpha.term")
		dashboard.section.terminal.command = vim.fn.stdpath("config") .. "/nvim-logo -t"
		dashboard.section.terminal.width = 70
		dashboard.section.terminal.height = 10
		dashboard.section.terminal.opts.redraw = true
		dashboard.section.terminal.opts.window_config.zindex = 1
		-- offset placment for screenshots
		-- dashboard.section.terminal.opts.window_config.col = math.floor((vim.o.columns - 70) / 2 + 20)
		-- vim.cmd [[autocmd! User AlphaClosed]]

		dashboard.section.buttons.val = {
			dashboard.button('i', '    new file', ':ene <BAR> startinsert<CR>'),
			dashboard.button('o', '    old files', ':Telescope oldfiles<CR>'),
			dashboard.button('f', '󰥨    find file', ':Telescope file_browser<CR>'),
			dashboard.button('g', '󰱼    find text', ':Telescope live_grep_args<CR>'),
			dashboard.button('h', '    browse git', ':Flog<CR>'),
			dashboard.button('l', '󰒲    lazy', ':Lazy<CR>'),
			dashboard.button('m', '󱌣    mason', ':Mason<CR>'),
			dashboard.button('p', '󰄉    profile', ':Lazy profile<CR>'),
			dashboard.button('q', '󰭿    quit', ':qa<CR>'),
		}
		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = 'Normal'
			button.opts.hl_shortcut = 'Function'
		end
		dashboard.section.footer.opts.hl = "Special"
		dashboard.opts.layout = {
			dashboard.section.terminal,
			{ type = "padding", val = 4 },
			dashboard.section.buttons,
			dashboard.section.footer,
		}
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
				dashboard.section.footer.val = '󱐋 ' .. stats.count .. ' plugins loaded in ' .. ms .. 'ms'
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
