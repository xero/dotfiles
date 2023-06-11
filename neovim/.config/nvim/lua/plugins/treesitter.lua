return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    -- shows treesitter context in end of parenthesis
    "haringsrob/nvim_context_vt",
    "RRethy/nvim-treesitter-textsubjects",
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      ensure_installed = {
        "typescript",
        "javascript",
        "html",
        "tsx",
        "lua",
        "json",
        "rust",
        "css",
        "scss",
        "ruby",
        "php",
        "dockerfile",
        "bash",
        "python",
        "graphql",
        "regex",
        "yaml",
        "go",
        "terraform",
        "vim",
        "markdown",
        "markdown_inline",
        "regex",
      },
      highlight = {
        enable = true,
      },
      matchup = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "zi",
          node_incremental = "zi",
          scope_incremental = "zo",
          node_decremental = "zd"
        },
      },
      -- textobjects = {
      --   select = {
      --     enable = true,
      --     lookahead = true,
      --     keymaps = {
      --       ["af"] = "@function.outer",
      --       ["if"] = "@function.inner",
      --       ["ac"] = "@class.outer",
      --       ["ic"] = "@class.inner",
      --
      --       -- xml attribute
      --       ["ax"] = "@attribute.outer",
      --       ["ix"] = "@attribute.inner",
      --
      --       -- json
      --       ["ak"] = "@key.outer",
      --       ["ik"] = "@key.inner",
      --       ["av"] = "@value.outer",
      --       ["iv"] = "@value.inner",
      --     },
      --   },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>rp"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>rP"] = "@parameter.inner",
          },
        },
      --   move = {
      --     enable = true,
      --     set_jumps = true, -- whether to set jumps in the jumplist
      --     goto_next_start = {
      --       ["]m"] = "@function.outer",
      --       ["]]"] = "@class.outer",
      --     },
      --     goto_next_end = {
      --       ["]M"] = "@function.outer",
      --       ["]["] = "@class.outer",
      --     },
      --     goto_previous_start = {
      --       ["[m"] = "@function.outer",
      --       ["[["] = "@class.outer",
      --     },
      --     goto_previous_end = {
      --       ["[M"] = "@function.outer",
      --       ["[]"] = "@class.outer",
      --     },
      --   },
      -- },
      textsubjects = {
        enable = true,
        keymaps = {
          ["."] = "textsubjects-smart",
          [";"] = "textsubjects-container-outer",
          ['i;'] = 'textsubjects-container-inner',
        },
      },
    })

    local r = require("utils.remaps")

    r.which_key("<leader>dt", "Treesitter")

    r.noremap("n", "<leader>dtp", function()
      vim.treesitter.inspect_tree({ command = "botright 60vnew" })
    end, "Treesitter playground")

    r.noremap("n", "<leader>dtt", "<cmd>TSHighlightCapturesUnderCursor<CR>", "Shows highlight colors under cursor")

    r.map_virtual("zi", "Init selection")
    r.map_virtual("zi", "Expand node")
    r.map_virtual("zo", "Expand scope")
    r.map_virtual("zd", "Decrement scope")

    -- r.map_virtual("af", "Function outer motion")
    -- r.map_virtual("if", "Function inner motion")
    -- r.map_virtual("ac", "Class outer motion")
    -- r.map_virtual("ic", "Class inner motion")
    --
    -- r.map_virtual("ax", "Attribute (html, xml) outer motion")
    -- r.map_virtual("ix", "Attribute (html, xml) inner motion")
    --
    -- r.map_virtual("ak", "Json key outer motion")
    -- r.map_virtual("ik", "Json key inner motion")
    --
    -- r.map_virtual("av", "Json value outer motion")
    -- r.map_virtual("iv", "Json value inner motion")
    --
    -- r.which_key("fp", "parameters")
    --
    r.map_virtual("<leader>rp", "Swap parameter to next")
    r.map_virtual("<leader>rP", "Swap parameter to previous")
    --
    -- r.map_virtual("]m", "Go to next function (start)")
    -- r.map_virtual("]M", "Go to next function (end)")
    --
    -- r.map_virtual("]]", "Go to next class (start)")
    -- r.map_virtual("][", "Go to next class (end)")
    --
    -- r.map_virtual("[m", "Go to previous function (start)")
    -- r.map_virtual("[M", "Go to previous function (end)")
    --
    -- r.map_virtual("[[", "Go to previous class (start)")
    -- r.map_virtual("[]", "Go to previous class (end)")
  end,
  build = function()
    vim.cmd([[TSUpdate]])
  end,
}
