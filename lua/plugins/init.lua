local telescope_opts = require "nvchad.configs.telescope"
vim.tbl_extend("force", telescope_opts.defaults, { path_display = { "filename_first", "truncate" } })

-- Import select_one_or_multi function from telescope.lua
local select_one_or_multi = require("configs.telescope").select_one_or_multi

return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        git_ignored = false,
        dotfiles = false,
      },
      view = {
        width = 65, -- Set the width of the NvimTree window
      },
    },
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  --
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "elixir",
        "eex",
        "heex",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  --
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
            ["<CR>"] = select_one_or_multi,
          },
          n = {

            ["<C-h>"] = "which_key",
            ["<C-x>"] = "delete_buffer",
            ["<CR>"] = select_one_or_multi,
          },
        },
      },
    },
  },
  {
    "hedyhli/markdown-toc.nvim",
    ft = "markdown", -- Lazy load on markdown filetype
    cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
    opts = {
      fences = { enabled = false },
      -- Your configuration here (optional)
    },
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      suggestion = { enabled = false },
    },
    -- config = function()
    --   require("copilot").setup {
    --     suggestion = { enabled = true },
    --     panel = { enabled = false },
    --   }
    -- end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "zbirenbaum/copilot-cmp",
    },
    opts = function(_, opts)
      local cmp = require "cmp"

      table.insert(opts.sources, 1, { name = "copilot", group_index = 2 })
      opts.completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      }
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        },
      })
    end,
  },
  {
    "rasulomaroff/reactive.nvim",
    cmd = "ReactiveStart",
    config = function()
      require("reactive").setup {
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = true,
        },
      }
    end,
  },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = "MCPHub",
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup {
        --- `mcp-hub` binary related options-------------------
        config = vim.fn.expand "~/.config/mcphub/servers.json", -- Absolute path to MCP Servers config file (will create if not exists)
        port = 37373, -- The port `mcp-hub` server listens to
        shutdown_delay = 5 * 60 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 5 minutes)
        use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
        mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
        global_env = {}, -- Global environment variables available to all MCP servers (can be a table or a function returning a table)
      }
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = function()
      return "make"
    end,
    opts = {
      provider = "copilot",
      selector = {
        provider = "telescope",
        provider_opts = telescope_opts,
      },
      mappings = {
        submit = {
          insert = "<C-CR>",
        },
      },
      -- system_prompt as function ensures LLM always has latest MCP server state
      -- This is evaluated for every message, even in existing chats
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Using function prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions

      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
