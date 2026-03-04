-- ▄█▀▀▄ ▄█▀█ ▄█▀▀▄ ▄█ █ ▄█ ▄█▄ ▄█
-- ▓█  █ ▓█▄  ▓█  █ ▓█ █ ▓█ ▓█ ▀ █
-- ▓█  █ ▓█ ▄ ▓█  █ ▓█ █ ▓█ ▓█   █
-- ▓█  █ ▓█▄█ ▀█▄▄▀ ▀█▄▀ ▓█ ▓█   █
--
-- ░ config from xero's dotfiles
-- ▒ author: xero (x@xero.style)
-- ▓ https://git.io/.files
-- █ https://code.x-e.ro/dotfiles

-- load general settings & commands
require("cfg.general")
require("cfg.commands")
require("cfg.ui")

-- opt out of loading all plugins with this invocation flag: nvim --cmd ":lua vim.g.noplugins=1"
if vim.g.noplugins == nil then
	require("cfg.lazy")
else
-- apply a simple colorscheme only
	vim.cmd("source " .. vim.fn.stdpath("data") .. "/lazy/evangelion.nvim/extras/evangelion.vim")
end
