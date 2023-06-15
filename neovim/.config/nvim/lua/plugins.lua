local pluginspath = vim.fn.stdpath("data") .. "/lazy"
local lazypath = pluginspath .. "/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone",
		"--filter=blob:none", "--single-branch",
		"https://github.com/folke/lazy.nvim.git", lazypath,
	})
end

vim.opt.runtimepath:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print("lazy just installed, please restart neovim")
	return
end

lazy.setup({
	{
		"xero/sourcerer",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme miasma]])
		end
	},
	{ 'xero/vim-noctu' },
	require("plugins.osc52-yank"),
	require("plugins.git"),
	require("plugins.tmux"),
	require("plugins.scrollbar"),
	require("plugins.gitsigns"),
	require("plugins.luasnip"),
	require("plugins.which-key"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.mason"),
	require("plugins.mason-dap"),
	require("plugins.mason-null-ls"),
	require("plugins.null-ls"),
	require("plugins.lsp"),
	require("plugins.cmp"),
  require("plugins.colorizer"),
	require("plugins.undotree"),
	require("plugins.ansi"),
	require("plugins.lualine"),
	{ 'nvim-tree/nvim-web-devicons' },
--  { 'mattn/vim-sl' },
--  require("plugins.autopairs"),
--  require("plugins.copilot"),
})
