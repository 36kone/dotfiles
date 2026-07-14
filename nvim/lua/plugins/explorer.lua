return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,

        exclude = {
          ".git",
          -- Python
          "__pycache__",
          ".venv",
          "venv",
          ".mypy_cache",
          ".pytest_cache",
          ".ruff_cache",
          "*.pyc",
          -- TS / React / JS
          "node_modules",
          ".next",
          ".turbo",
          -- Rust
          "target",
          -- Go
          "vendor",
          -- Diversos
          ".DS_Store",
        },

        sources = {
          explorer = {
            follow_file = false,
            layout = { layout = { position = "right" } },
          },
        },
      },
    },
  },
}
