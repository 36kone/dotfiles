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
}
