return function(on_attach)
  return {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      client.server_capabilities.document_formatting = true
    end,
    settings = {
      format = { enable = true },
    },
  }
end
