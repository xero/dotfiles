return {
  "williamboman/mason.nvim",
  config = function()
    local mason = require("mason")

    mason.setup()
  end,
}
