local pluginspath = vim.fn.stdpath("data") .. "/lazy"
local lazypath = pluginspath .. "/lazy.nvim"
-- install lazy
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

-- use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print("lazy just installed, please restart neovim")
	return
end

-- install plugins
lazy.setup({
	spec = {
		{
			"xero/miasma.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd([[colorscheme miasma]])
			end,
		},
		require("plugins.osc52-yank"),
		require("plugins.git"),
		require("plugins.tmux"),
		require("plugins.scrollbar"),
		require("plugins.gitsigns"),
		require("plugins.luasnip"),
		require("plugins.which-key"),
		require("plugins.telescope"),
		require("plugins.treesitter"),
		require("plugins.guess-indent"),
		require("plugins.mason"),
		require("plugins.mason-dap"),
		require("plugins.mason-null-ls"),
		require("plugins.null-ls"),
		require("plugins.lsp"),
		require("plugins.cmp"),
		require("plugins.colorizer"),
		require("plugins.tint"),
		require("plugins.ansi"),
		require("plugins.lualine"),
		require("plugins.increname"),
		require("plugins.devicons"),
		require("plugins.matchparen"),
		--{ "xero/sourcerer.vim" },
		--{ 'xero/vim-noctu' },
		--{ 'mattn/vim-sl' }, -- train
		--require("plugins.autopairs"),
		--require("plugins.copilot"),
	},
	dev = {
		path = "~src",
	},
	lockfile = vim.fn.stdpath("config") .. "/lua/plugins/lazy-lock.json",
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "shadow",
		icons = require("utils.icons").lazy,
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
