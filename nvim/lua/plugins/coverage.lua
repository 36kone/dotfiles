return {
  -- Mostra a cobertura de testes no gutter (linhas cobertas / não cobertas),
  -- lendo o coverage que seus testes já geram:
  --   Python -> .coverage (pytest-cov)   Go -> profile    Rust -> etc.
  -- Fluxo: rode os testes com cobertura (ex: `hatch run test`), depois
  -- <leader>tc dentro do arquivo pra ver os sinais na margem.
  {
    "andythigpen/nvim-coverage",

    dependencies = { "nvim-lua/plenary.nvim" },

    cmd = {
      "Coverage",
      "CoverageLoad",
      "CoverageShow",
      "CoverageHide",
      "CoverageToggle",
      "CoverageClear",
      "CoverageSummary",
    },

    opts = {
      auto_reload = true,
    },

    config = function(_, opts)
      require("coverage").setup(opts)
    end,

    keys = {
      { "<leader>tc", "<cmd>Coverage<cr>", desc = "Coverage (carrega + mostra)" },
      { "<leader>tC", "<cmd>CoverageSummary<cr>", desc = "Coverage summary" },
      { "<leader>tx", "<cmd>CoverageClear<cr>", desc = "Coverage clear" },
    },
  },
}
