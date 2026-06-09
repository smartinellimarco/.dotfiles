return {
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true },
      format = { enable = true },
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
