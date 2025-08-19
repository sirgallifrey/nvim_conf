local telescope_opts = require "nvchad.configs.telescope"
local telescope_defaults = { path_display = { "filename_first", "truncate" } }
vim.tbl_extend("force", telescope_opts.defaults, telescope_defaults)

local select_one_or_multi = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require("telescope.actions").close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then
        vim.cmd(string.format("%s %s", "edit", j.path))
      end
    end
  else
    require("telescope.actions").select_default(prompt_bufnr)
  end
end

local get_opts = function()
  return telescope_opts
end

return {
  get_opts = get_opts,
  select_one_or_multi = select_one_or_multi,
}
