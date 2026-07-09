return {
  -- Ferramentas de Go backend (estilo GoLand): struct tags, if err, gerar
  -- testes, implementar interface, preencher struct. Complementa o gopls.
  {
    "ray-x/go.nvim",

    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },

    ft = { "go", "gomod" },

    -- Instala os binários auxiliares (gomodifytags, iferr, impl, gotests...)
    -- via `go install`. Precisa do Go no PATH — já configuramos.
    build = ':lua require("go.install").update_all_sync()',

    opts = {
      -- O gopls já é configurado pelo LazyVim/lspconfig e o format-on-save
      -- é do conform (goimports+gofumpt). Desligamos aqui pra não duplicar
      -- LSP nem formatar duas vezes.
      lsp_cfg = false,
      lsp_keymaps = false,
      lsp_inlay_hints = { enable = false }, -- inlay hints vêm do seu config
      trouble = true,
      luasnip = false,
    },

    config = function(_, opts)
      require("go").setup(opts)
    end,

    -- Grupo <leader>G (Go), maiúsculo p/ não colidir com git (<leader>g).
    keys = {
      { "<leader>Gt", "<cmd>GoAddTag<cr>", desc = "Go: add struct tags", ft = "go" },
      { "<leader>GT", "<cmd>GoRmTag<cr>", desc = "Go: remove struct tags", ft = "go" },
      { "<leader>Ge", "<cmd>GoIfErr<cr>", desc = "Go: add if err", ft = "go" },
      { "<leader>Gi", "<cmd>GoImpl<cr>", desc = "Go: implement interface", ft = "go" },
      { "<leader>Gf", "<cmd>GoFillStruct<cr>", desc = "Go: fill struct", ft = "go" },
      { "<leader>Gu", "<cmd>GoAddTest<cr>", desc = "Go: gerar teste da função", ft = "go" },
      { "<leader>Gc", "<cmd>GoCmt<cr>", desc = "Go: doc comment", ft = "go" },
    },
  },
}
