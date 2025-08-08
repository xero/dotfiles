local vim = vim
local X = {}

X.cmd = function(name, command, desc)
	vim.api.nvim_create_user_command(name, command, desc)
end

X.autocmd = function(evt, opts)
	vim.api.nvim_create_autocmd(evt, opts)
end

return X
