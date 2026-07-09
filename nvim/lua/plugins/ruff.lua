return {
  -- Ruff = lint + format do Python (substitui black + isort + flake8).
  -- No LazyVim o format-on-save já roda via conform.nvim (mesmo mecanismo
  -- que formata Go/gopls). Aqui só apontamos o conform pro ruff.
  --
  -- Divisão de tarefas no Python:
  --   pyright -> type-checking (ver lua/plugins/lsp.lua)
  --   ruff    -> lint + organize imports + format
  -- Todas as regras (select/ignore/isort/quote-style) vêm do pyproject.toml
  -- do projeto automaticamente — o ruff lê o arquivo sozinho.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = {
          -- ordem importa: primeiro organiza imports (isort), depois formata.
          "ruff_organize_imports",
          "ruff_format",
        },
      },
    },
  },

  -- Instala o binário do ruff via Mason (idempotente).
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "ruff",
      })
    end,
  },
}
