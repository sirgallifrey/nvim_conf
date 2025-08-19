return {
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
}
