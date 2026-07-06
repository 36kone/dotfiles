return {
  "lucasdetoledo4/fastapi-nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  ft = "python",
  opts = {
    -- Exibe o endpoint completo ao lado do decorator
    virtual_text = {
      enabled = true,
      prefix = "󰊕 ",
    },

    -- Telescope
    telescope = {
      layout_strategy = "horizontal",
      layout_config = {
        width = 0.90,
        height = 0.85,
        preview_width = 0.60,
      },
    },
  },
  keys = {
    {
      "<leader>fa",
      function()
        require("fastapi").find_routes()
      end,
      desc = "FastAPI Routes",
    },
    {
      "<leader>fA",
      function()
        require("fastapi").refresh()
      end,
      desc = "FastAPI Refresh",
    },
  },
}
