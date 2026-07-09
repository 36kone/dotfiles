return {
  -- Format-on-save pras demais linguagens (Python já está no ruff.lua,
  -- Rust já vem do rustaceanvim/rustfmt). O conform é o mesmo mecanismo,
  -- então só declaramos os formatters por filetype aqui.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        -- Go: goimports organiza imports, gofumpt formata (mais estrito
        -- que o gofmt padrão). Rodam em sequência.
        go = { "goimports", "gofumpt" },

        -- TS / JS / React + web em geral: prettierd (daemon, mais rápido),
        -- caindo pro prettier se o daemon não existir.
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        css = { "prettierd", "prettier", stop_after_first = true },
        scss = { "prettierd", "prettier", stop_after_first = true },
        html = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "prettierd", "prettier", stop_after_first = true },
        markdown = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- Binários via Mason (idempotente).
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "goimports",
        "gofumpt",
        "prettierd",
      })
    end,
  },
}
