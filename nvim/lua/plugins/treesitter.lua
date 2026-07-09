return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- linguagens que você usa
        "go",
        "python",
        "rust",
        "javascript",
        "typescript",
        "tsx",
        "java",
        "sql",
        "regex",
        "gitignore",
        "dockerfile",

        -- base do LazyVim
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
      },

      highlight = {
        enable = true,
      },

      indent = {
        enable = true,
      },
    },
  },

  -------------------------------------------------
  -- nvim-treesitter-context
  -------------------------------------------------
  -- Fixa no topo da janela a assinatura da função/classe/bloco atual
  -- enquanto você rola (o "sticky header" / breadcrumbs do JetBrains).
  {
    "nvim-treesitter/nvim-treesitter-context",

    event = {
      "BufReadPre",
      "BufNewFile",
    },

    opts = {
      -- Limita o cabeçalho fixado a poucas linhas pra não comer a tela.
      max_lines = 3,
      multiline_threshold = 1,
      trim_scope = "outer",
    },

    keys = {
      {
        "<leader>ut",
        function()
          require("treesitter-context").toggle()
        end,
        desc = "Toggle Treesitter Context",
      },
    },
  },
}
