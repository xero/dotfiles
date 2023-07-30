local ext_fmt = function(cmd)
	return function()
		vim.cmd [[:silent w!]]
		vim.cmd((":silent !%s %%"):format(cmd))
		vim.cmd [[:silent e]]
	end
end

local int_fmt = function()
	vim.lsp.buf.formatting {}
end

local cmds = {
	cmake = ext_fmt "cmake-format -i",
	c = ext_fmt "clang-format --style=file -i",
	cpp = ext_fmt "clang-format --style=file -i",
	rust = int_fmt,
	go = int_fmt,
	python = ext_fmt "black",
	html = ext_fmt "prettier -w",
	yaml = ext_fmt "prettier -w",
	json = ext_fmt "prettier -w",
	svelte = ext_fmt "prettier -w",
	javascript = ext_fmt "prettier -w",
	typescript = ext_fmt "prettier -w",
	lua = ext_fmt "stylua",
	java = ext_fmt "astyle -A2 -s2 -c -J -n -q -z2 -xC80",
	sh = ext_fmt "shfmt -w -i 2 -ci -sr",
	bash = ext_fmt "shfmt -w -i 2 -ci -sr",
	nix = ext_fmt "nixpkgs-fmt",
	php = ext_fmt "php-cs-fixer fix --rules=@PSR12",
}

local X = {}
X.run = function()
	cmds[vim.o.filetype]()
end

return X
