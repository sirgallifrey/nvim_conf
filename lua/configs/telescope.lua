local telescope_defaults = { path_display = { "filename_first", "truncate" } }

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

local telescope_opts

local setup_telescope_opts = function()
  telescope_opts = require "nvchad.configs.telescope"
  vim.tbl_extend("force", telescope_opts.defaults, telescope_defaults)
end

local get_telescope_opts = function()
  if telescope_opts == nil then
    setup_telescope_opts()
  end
  return telescope_opts
end

-- Export the function
return {
  setup_opts = setup_telescope_opts,
  get_opts = get_telescope_opts,
  select_one_or_multi = select_one_or_multi,
}
