local curl = require "plenary.curl"

local fetch = function(url, options)
  return curl.post(url, {
    body = vim.fn.json_encode(options.body),
    timeout = 1000,
    headers = {
      content_type = "application/json",
    },
  })
end

return fetch
