local telescope_config = require "configs.telescope"
local actions = require "telescope.actions"

telescope_config.get_opts()

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        path_display = { "filename_first", "truncate" },
        mappings = {
          i = {
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            ["<C-h>"] = "which_key",
            ["<C-x>"] = "delete_buffer",
            ["<CR>"] = telescope_config.select_one_or_multi,
            ["<C-f>"] = actions.send_to_qflist,
          },
          n = {

            ["<C-h>"] = "which_key",
            ["<C-x>"] = "delete_buffer",
            ["<CR>"] = telescope_config.select_one_or_multi,
            ["<C-f>"] = actions.send_to_qflist,
          },
        },
      },
    },
  },
}
