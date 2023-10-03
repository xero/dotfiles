local ext_fmt = function(cmd)
	return function()
		local view = vim.fn.winsaveview()
		vim.cmd [[:silent w!]]
		vim.cmd((":silent !%s %%"):format(cmd))
		vim.cmd [[:silent syntax sync fromstart]]
		vim.fn.winrestview(view)
		vim.cmd [[:silent redraw!]]
		vim.cmd [[:silent e]]
	end
end

local int_fmt = function() vim.lsp.buf.formatting {} end

local cmds = {
	c = ext_fmt "clang-format --style=file -i",
	cmake = ext_fmt "cmake-format -i",
	cpp = ext_fmt "clang-format --style=file -i",
	css = ext_fmt "prettier -w",
	go = int_fmt,
	html = ext_fmt "prettierd -w",
	java = ext_fmt "astyle -A2 -s2 -c -J -n -q -z2 -xC80",
	javascript = ext_fmt "prettier -w",
	json = ext_fmt "prettierd -w",
	lua = ext_fmt "stylua",
	nix = ext_fmt "nixpkgs-fmt",
	php = ext_fmt "php-cs-fixer fix --rules=@PSR12",
	python = ext_fmt "black",
	rust = int_fmt,
	sh = ext_fmt "shfmt -w -i 0 -sr -kp",
	typescript = ext_fmt "prettier -w",
	yaml = ext_fmt "prettier -w",
}

local X = {}
X.run = function()
	cmds[vim.o.filetype]()
end
return X
