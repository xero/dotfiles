return {
  "folke/which-key.nvim",
  keys = { "<leader>" },
  config = function()
    local which_key = require("which-key")

    local opts = {
      prefix = "<leader>",
    }

    which_key.setup()

    local groups = {
      b = { name = "buffer" },
      s = { name = "search" },
      p = { name = "project" },
      ["ps"] = { name = "session" },
      w = { name = "window" },
      g = { name = "git" },
      t = { name = "types" },
      r = { name = "refactor" },
      l = { name = "lsp" },
      d = { name = "debug" },
      z = { name = "zen" },
      m = { name = "macro/markdown" },
      n = { name = "notifications" },
      q = { name = "quick switcher" },
      k = { name = "terminal" },
      [";"] = { name = "test" },
      ["'"] = { name = "marks" },
      ['"'] = { name = "registers" },
      ["/"] = { name = "search" },
      ["/g"] = { name = "git" },
      ["/gd"] = { name = "diff" },
      ["["] = { name = "previous" },
      ["]"] = { name = "next" },
    }

    which_key.register(groups, opts)
  end,
}
