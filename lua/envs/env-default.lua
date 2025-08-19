-- Default implementation of Env specific config/functions
-- This file contains the base implementation which can be shared on Github
-- When some specific implementation needs to be done and can't be shared with github or other machines,
-- then clone this file into env-local.lua and implement it there

local M = {}

M.shouldLoadAIModules = function()
  return true
end

return M
