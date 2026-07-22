return {
  -- LazyVim's default file explorer
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "folke/snacks.nvim",
    opts = {
      picker = { enabled = true },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
    },
    keys = {
      {
        "<leader>e",
        function()
          Snacks.explorer({ cwd = LazyVim.root() })
        end,
        desc = "Explorer (Root Dir)",
      },
      {
        "<leader>E",
        function()
          Snacks.explorer({ cwd = vim.uv.cwd() })
        end,
        desc = "Explorer (cwd)",
      },
    },
  },
}
