return {
	"nvim-tree/nvim-web-devicons",
	event = "VeryLazy",
	config = function()
		require("nvim-web-devicons").setup({
		-- yes, this is all the icons w/ an extra space
			override = {
				["default_icon"] = {
					icon = "󱔗 ",
				},
				[".babelrc"] = {
					icon = " ",
				},
				[".bash_profile"] = {
					icon = " ",
				},
				[".bashrc"] = {
					icon = " ",
				},
				[".ds_store"] = {
					icon = " ",
				},
				[".eslintrc"] = {
					icon = " ",
				},
				[".gitattributes"] = {
					icon = " ",
				},
				[".gitconfig"] = {
					icon = " ",
				},
				[".gitignore"] = {
					icon = " ",
				},
				[".gitlab-ci.yml"] = {
					icon = " ",
				},
				[".gitmodules"] = {
					icon = " ",
				},
				[".gvimrc"] = {
					icon = " ",
				},
				[".npmignore"] = {
					icon = " ",
				},
				[".npmrc"] = {
					icon = " ",
				},
				[".settings.json"] = {
					icon = " ",
				},
				[".vimrc"] = {
					icon = " ",
				},
				[".zprofile"] = {
					icon = " ",
				},
				[".zshenv"] = {
					icon = " ",
				},
				[".zshrc"] = {
					icon = " ",
				},
				["brewfile"] = {
					icon = " ",
				},
				["cmakelists.txt"] = {
					icon = " ",
				},
				["commit_editmsg"] = {
					icon = " ",
				},
				["containerfile"] = {
					icon = "󰡨 ",
				},
				["copying"] = {
					icon = " ",
				},
				["copying.lesser"] = {
					icon = " ",
				},
				["docker-compose.yml"] = {
					icon = "󰡨 ",
				},
				["docker-compose.yaml"] = {
					icon = "󰡨 ",
				},
				[".dockerignore"] = {
					icon = "󰡨 ",
				},
				["gemfile$"] = {
					icon = " ",
				},
				["vagrantfile$"] = {
					icon = " ",
				},
				["_gvimrc"] = {
					icon = " ",
				},
				["_vimrc"] = {
					icon = " ",
				},
				["package.json"] = {
					icon = " ",
				},
				["package-lock.json"] = {
					icon = " ",
				},
				["node_modules"] = {
					icon = " ",
				},
				["favicon.ico"] = {
					icon = " ",
				},
				["mix.lock"] = {
					icon = " ",
				},
				[".env"] = {
					icon = " ",
				},
				["gruntfile"] = {
					icon = " ",
				},
				["gulpfile"] = {
					icon = " ",
				},
				["rakefile"] = {
					icon = " ",
				},
				["procfile"] = {
					icon = " ",
				},
				["dockerfile"] = {
					icon = "󰡨 ",
				},
				["build"] = {
					icon = " ",
				},
				["workspace"] = {
					icon = " ",
				},
				["unlicense"] = {
					icon = " ",
				},
				["ai"] = {
					icon = " ",
				},
				["awk"] = {
					icon = " ",
				},
				["bash"] = {
					icon = " ",
				},
				["bat"] = {
					icon = " ",
				},
				["bazel"] = {
					icon = " ",
				},
				["bzl"] = {
					icon = " ",
				},
				["bmp"] = {
					icon = " ",
				},
				["c"] = {
					icon = " ",
				},
				["c++"] = {
					icon = " ",
				},
				["cbl"] = {
					icon = "⚙ ",
				},
				["cc"] = {
					icon = " ",
				},
				["cfg"] = {
					icon = " ",
				},
				["cjs"] = {
					icon = " ",
				},
				["clj"] = {
					icon = " ",
				},
				["cljc"] = {
					icon = " ",
				},
				["cljs"] = {
					icon = " ",
				},
				["cljd"] = {
					icon = " ",
				},
				["cmake"] = {
					icon = " ",
				},
				["cob"] = {
					icon = "⚙ ",
				},
				["cobol"] = {
					icon = "⚙ ",
				},
				["coffee"] = {
					icon = " ",
				},
				["conf"] = {
					icon = " ",
				},
				["config.ru"] = {
					icon = " ",
				},
				["cp"] = {
					icon = " ",
				},
				["cpp"] = {
					icon = " ",
				},
				["cpy"] = {
					icon = "⚙ ",
				},
				["cr"] = {
					icon = " ",
				},
				["cs"] = {
					icon = "󰌛 ",
				},
				["csh"] = {
					icon = " ",
				},
				["cson"] = {
					icon = " ",
				},
				["css"] = {
					icon = " ",
				},
				["csv"] = {
					icon = "󰈙 ",
				},
				["cxx"] = {
					icon = " ",
				},
				["d"] = {
					icon = " ",
				},
				["dart"] = {
					icon = " ",
				},
				["db"] = {
					icon = " ",
				},
				["desktop"] = {
					icon = " ",
				},
				["diff"] = {
					icon = " ",
				},
				["doc"] = {
					icon = "󰈬 ",
				},
				["docx"] = {
					icon = "󰈬 ",
				},
				["drl"] = {
					icon = " ",
				},
				["dropbox"] = {
					icon = " ",
				},
				["dump"] = {
					icon = " ",
				},
				["edn"] = {
					icon = " ",
				},
				["eex"] = {
					icon = " ",
				},
				["ejs"] = {
					icon = " ",
				},
				["elm"] = {
					icon = " ",
				},
				["epp"] = {
					icon = " ",
				},
				["erb"] = {
					icon = " ",
				},
				["erl"] = {
					icon = " ",
				},
				["ex"] = {
					icon = " ",
				},
				["exs"] = {
					icon = " ",
				},
				["f#"] = {
					icon = " ",
				},
				["f90"] = {
					icon = "󱈚 ",
				},
				["fnl"] = {
					icon = "🌜 ",
				},
				["fish"] = {
					icon = " ",
				},
				["fs"] = {
					icon = " ",
				},
				["fsi"] = {
					icon = " ",
				},
				["fsscript"] = {
					icon = " ",
				},
				["fsx"] = {
					icon = " ",
				},
				["gd"] = {
					icon = " ",
				},
				["gemspec"] = {
					icon = " ",
				},
				["gif"] = {
					icon = " ",
				},
				["git"] = {
					icon = " ",
				},
				["glb"] = {
					icon = " ",
				},
				["go"] = {
					icon = " ",
				},
				["godot"] = {
					icon = " ",
				},
				["graphql"] = {
					icon = " ",
				},
				["gql"] = {
					icon = " ",
				},
				["h"] = {
					icon = " ",
				},
				["haml"] = {
					icon = " ",
				},
				["hbs"] = {
					icon = " ",
				},
				["heex"] = {
					icon = " ",
				},
				["hh"] = {
					icon = " ",
				},
				["hpp"] = {
					icon = " ",
				},
				["hrl"] = {
					icon = " ",
				},
				["hs"] = {
					icon = " ",
				},
				["htm"] = {
					icon = " ",
				},
				["html"] = {
					icon = " ",
				},
				["hxx"] = {
					icon = " ",
				},
				["ico"] = {
					icon = " ",
				},
				["import"] = {
					icon = " ",
				},
				["ini"] = {
					icon = " ",
				},
				["java"] = {
					icon = " ",
				},
				["jl"] = {
					icon = " ",
				},
				["jpeg"] = {
					icon = " ",
				},
				["jpg"] = {
					icon = " ",
				},
				["js"] = {
					icon = " ",
				},
				["test.js"] = {
					icon = " ",
				},
				["spec.js"] = {
					icon = " ",
				},
				["json"] = {
					icon = " ",
				},
				["json5"] = {
					icon = " ",
				},
				["jsx"] = {
					icon = " ",
				},
				["test.jsx"] = {
					icon = " ",
				},
				["spec.jsx"] = {
					icon = " ",
				},
				["ksh"] = {
					icon = " ",
				},
				["kt"] = {
					icon = " ",
				},
				["kts"] = {
					icon = " ",
				},
				["leex"] = {
					icon = " ",
				},
				["less"] = {
					icon = " ",
				},
				["lhs"] = {
					icon = " ",
				},
				["license"] = {
					icon = " ",
				},
				["lua"] = {
					icon = " ",
				},
				["luau"] = {
					icon = " ",
				},
				["gnumakefile"] = {
					icon = " ",
				},
				["makefile"] = {
					icon = " ",
				},
				["mk"] = {
					icon = " ",
				},
				["markdown"] = {
					icon = " ",
				},
				["material"] = {
					icon = "󰔉 ",
				},
				["md"] = {
					icon = " ",
				},
				["mdx"] = {
					icon = " ",
				},
				["mint"] = {
					icon = "󰌪 ",
				},
				["mjs"] = {
					icon = " ",
				},
				["ml"] = {
					icon = "λ ",
				},
				["mli"] = {
					icon = "λ ",
				},
				["mo"] = {
					icon = "∞ ",
				},
				["mustache"] = {
					icon = " ",
				},
				["nim"] = {
					icon = " ",
				},
				["nix"] = {
					icon = " ",
				},
				["opus"] = {
					icon = "󰈣 ",
				},
				["org"] = {
					icon = " ",
				},
				["otf"] = {
					icon = " ",
				},
				["pck"] = {
					icon = " ",
				},
				["pdf"] = {
					icon = " ",
				},
				["php"] = {
					icon = " ",
				},
				["pl"] = {
					icon = " ",
				},
				["pm"] = {
					icon = " ",
				},
				["png"] = {
					icon = " ",
				},
				["pp"] = {
					icon = " ",
				},
				["ppt"] = {
					icon = "󰈧 ",
				},
				["pro"] = {
					icon = " ",
				},
				["ps1"] = {
					icon = "󰨊 ",
				},
				["psd1"] = {
					icon = "󰨊 ",
				},
				["psm1"] = {
					icon = "󰨊 ",
				},
				["psb"] = {
					icon = " ",
				},
				["psd"] = {
					icon = " ",
				},
				["py"] = {
					icon = " ",
				},
				["pyc"] = {
					icon = " ",
				},
				["pyd"] = {
					icon = " ",
				},
				["pyo"] = {
					icon = " ",
				},
				["query"] = {
					icon = " ",
				},
				["r"] = {
					icon = "󰟔 ",
				},
				["rake"] = {
					icon = " ",
				},
				["rb"] = {
					icon = " ",
				},
				["README"] = {
					icon = "󰑇 ",
				},
				["README.md"] = {
					icon = "󰑇 ",
				},
				["res"] = {
					icon = " ",
				},
				["resi"] = {
					icon = " ",
				},
				["rlib"] = {
					icon = " ",
				},
				["rmd"] = {
					icon = " ",
				},
				["robots.txt"] = {
					icon = "󱚤 ",
				},
				["rproj"] = {
					icon = "󰗆 ",
				},
				["rs"] = {
					icon = " ",
				},
				["rss"] = {
					icon = " ",
				},
				["sass"] = {
					icon = " ",
				},
				["sbt"] = {
					icon = " ",
				},
				["scala"] = {
					icon = " ",
				},
				["scm"] = {
					icon = "󰘧 ",
				},
				["scss"] = {
					icon = " ",
				},
				["sh"] = {
					icon = " ",
				},
				["sig"] = {
					icon = "λ ",
				},
				["slim"] = {
					icon = " ",
				},
				["sln"] = {
					icon = " ",
				},
				["sml"] = {
					icon = "λ ",
				},
				["sql"] = {
					icon = " ",
				},
				["sqlite"] = {
					icon = " ",
				},
				["sqlite3"] = {
					icon = " ",
				},
				["styl"] = {
					icon = " ",
				},
				["sublime"] = {
					icon = " ",
				},
				["suo"] = {
					icon = " ",
				},
				["sv"] = {
					icon = "󰍛 ",
				},
				["svelte"] = {
					icon = " ",
				},
				["svh"] = {
					icon = "󰍛 ",
				},
				["svg"] = {
					icon = "󰜡 ",
				},
				["swift"] = {
					icon = " ",
				},
				["t"] = {
					icon = " ",
				},
				["tbc"] = {
					icon = "󰛓 ",
				},
				["tcl"] = {
					icon = "󰛓 ",
				},
				["terminal"] = {
					icon = " ",
				},
				["tex"] = {
					icon = "󰙩 ",
				},
				["tf"] = {
					icon = " ",
				},
				["tfvars"] = {
					icon = " ",
				},
				["toml"] = {
					icon = " ",
				},
				["tres"] = {
					icon = " ",
				},
				["ts"] = {
					icon = " ",
				},
				["test.ts"] = {
					icon = " ",
				},
				["spec.ts"] = {
					icon = " ",
				},
				["tscn"] = {
					icon = "󰎁 ",
				},
				["tsx"] = {
					icon = " ",
				},
				["test.tsx"] = {
					icon = " ",
				},
				["spec.tsx"] = {
					icon = " ",
				},
				["twig"] = {
					icon = " ",
				},
				["txt"] = {
					icon = "󰈙 ",
				},
				["v"] = {
					icon = "󰍛 ",
				},
				["vala"] = {
					icon = " ",
				},
				["vh"] = {
					icon = "󰍛 ",
				},
				["vhd"] = {
					icon = "󰍛 ",
				},
				["vhdl"] = {
					icon = "󰍛 ",
				},
				["vim"] = {
					icon = " ",
				},
				["vue"] = {
					icon = " ",
				},
				["webmanifest"] = {
					icon = " ",
				},
				["webp"] = {
					icon = " ",
				},
				["webpack"] = {
					icon = "󰜫 ",
				},
				["xcplayground"] = {
					icon = " ",
				},
				["xls"] = {
					icon = "󰈛 ",
				},
				["xlsx"] = {
					icon = "󰈛 ",
				},
				["xml"] = {
					icon = "󰗀 ",
				},
				["xul"] = {
					icon = " ",
				},
				["yaml"] = {
					icon = " ",
				},
				["yml"] = {
					icon = " ",
				},
				["zig"] = {
					icon = " ",
				},
				["zsh"] = {
					icon = " ",
				},
				["sol"] = {
					icon = "󰞻 ",
				},
				["prisma"] = {
					icon = "󰔶 ",
				},
				["lock"] = {
					icon = " ",
				},
				["log"] = {
					icon = "󰌱 ",
				},
				["wasm"] = {
					icon = " ",
				},
				["liquid"] = {
					icon = " ",
				},
			},
		})
	end,
}
