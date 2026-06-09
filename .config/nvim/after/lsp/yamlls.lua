return {
  settings = {
    yaml = {
      schemaStore = {
        -- Disable built-in schemaStore support
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

-- vim: ts=2 sts=2 sw=2 et
