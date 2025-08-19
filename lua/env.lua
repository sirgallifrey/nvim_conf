local utils = require "util"

local default_env = require "envs.env-default"
local local_env = {}

if utils.isModuleAvailable "envs.env-local" then
  local_env = require "envs.env-local"
end

local M = vim.tbl_extend("force", default_env, local_env)

return M
