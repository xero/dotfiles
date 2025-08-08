local util = require 'lspconfig.util'
return function(on_attach)
	return {
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"gohtml",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"markdown",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"razor",
			"slim",
			"twig",
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			"reason",
			"rescript",
			"vue",
			"svelte"
		},
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb"
			}
		},
		root_dir = util.root_pattern(
			'tailwind.config.js',
			'tailwind.config.cjs',
			'tailwind.config.mjs',
			'tailwind.config.ts',
			'postcss.config.js',
			'postcss.config.cjs',
			'postcss.config.mjs',
			'postcss.config.ts',
			'package.json',
			'node_modules',
			'.git'
		),
		single_file_support = true,
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning"
				},
				validate = true
			}
		}
	}
end
