local keymap = vim.keymap
local check_duplicates = require("utils.duplicates").check_duplicates

local X = {}
local function try_add_to_which_key_by_input(input, description)
	require("which-key").add({{ input, description }})
end

function X.map(type, input, output, description, additional_options)
	local options = { remap = true, desc = description }
	if additional_options then
		options = vim.tbl_deep_extend("force", options, additional_options)
	end
	keymap.set(type, input, output, options)
	check_duplicates(type, input, description)
end

function X.noremap(type, input, output, description, additional_options)
	local options = { remap = false }
	if additional_options then
		options = vim.tbl_deep_extend("force", options, additional_options)
	end
	X.map(type, input, output, description, options)
end

function X.map_virtual(input, description)
	check_duplicates(type, input, description)
	try_add_to_which_key_by_input(input, description)
end

function X.which_key(input, description)
	try_add_to_which_key_by_input(input, description)
end

return X
