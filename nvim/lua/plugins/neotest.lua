return {
  {
    "nvim-neotest/neotest",

    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",

      -- Adapters por linguagem
      "nvim-neotest/neotest-python", -- pytest
      "fredrikaverpil/neotest-golang", -- go test (adapter mantido)
      "marilari88/neotest-vitest", -- vitest
      "nvim-neotest/neotest-jest", -- jest
      -- Rust: o adapter vem embutido no rustaceanvim (ver config abaixo).
    },

    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",
            -- justMyCode=false permite debugar dentro de libs também.
            dap = { justMyCode = false },
          }),
          require("neotest-golang"),
          require("neotest-vitest"),
          require("neotest-jest")({}),
          -- Rust reaproveita o adapter do rustaceanvim.
          require("rustaceanvim.neotest"),
        },
      })
    end,

    keys = {
      {
        "<leader>tt",
        function()
          require("neotest").run.run()
        end,
        desc = "Test nearest",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Test file",
      },
      {
        "<leader>ta",
        function()
          require("neotest").run.run(vim.uv.cwd())
        end,
        desc = "Test all (suite)",
      },
      -- Suíte toda em paralelo (pytest-xdist), igual ao `hatch run test-fast`.
      -- extra_args é repassado direto pro pytest — pode trocar o 6 pelo nº de
      -- workers que quiser. O conftest do projeto já cuida do container único
      -- compartilhado entre os workers.
      {
        "<leader>tA",
        function()
          require("neotest").run.run({
            vim.uv.cwd(),
            extra_args = { "-n", "6" },
          })
        end,
        desc = "Test all (fast, -n 6)",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Test last",
      },
      {
        "<leader>ts",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Test summary",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Test output",
      },
      {
        "<leader>tO",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Test output panel",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Test watch (file)",
      },
      -- Debug do teste sob o cursor, reaproveitando seu nvim-dap.
      {
        "<leader>td",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Test debug nearest",
      },
    },
  },
}
