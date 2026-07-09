return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- hidden  -> mostra dotfiles (.env, .gitignore, ...)
        -- ignored -> mostra o que está no .gitignore (ex: .env)
        -- Antes ignored=false escondia o .env mesmo com hidden=true.
        hidden = true,
        ignored = true,

        -- Com ignored=true, todo o lixo gitignored voltaria a aparecer.
        -- exclude sempre esconde estes, independente do .gitignore.
        -- Cobre Go / Python / TS-React / Rust.
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
      },
    },
  },
}
