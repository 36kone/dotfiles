return {
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",

      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",

      "mfussenegger/nvim-dap-python",
      "leoluz/nvim-dap-go",

      "mxsdev/nvim-dap-vscode-js",
    },

    keys = {

      {
        "<F5>",
        function()
          require("dap").continue()
        end,
        desc = "Debug continue",
      },

      {
        "<F10>",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },

      {
        "<F11>",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },

      {
        "<F12>",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },

      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Breakpoint",
      },

      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },

      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP UI",
      },

      -- FastAPI / debugpy attach
      {
        "<leader>da",
        function()
          require("dap").continue()
        end,
        desc = "Attach API",
      },

      -- Gin / Go attach
      {
        "<leader>dg",
        function()
          require("dap").continue()
        end,
        desc = "Attach Go",
      },
    },

    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      ------------------------------------------------
      -- UI
      ------------------------------------------------

      dapui.setup({
        layouts = {

          {
            elements = {
              "scopes",
              "breakpoints",
              "stacks",
              "watches",
            },

            size = 40,
            position = "left",
          },

          {
            elements = {
              "repl",
              "console",
            },

            size = 10,
            position = "bottom",
          },
        },
      })

      ------------------------------------------------
      -- Virtual text
      ------------------------------------------------

      require("nvim-dap-virtual-text").setup({
        commented = true,

        highlight_changed_variables = true,

        show_stop_reason = true,

        virt_text_pos = "eol",

        all_frames = false,

        virt_lines = false,
      })

      ------------------------------------------------
      -- Mason adapters
      ------------------------------------------------

      require("mason-nvim-dap").setup({
        automatic_installation = true,
      })

      ------------------------------------------------
      -- Python FastAPI
      ------------------------------------------------

      require("dap-python").setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python")

      dap.configurations.python = {

        {
          type = "python",

          request = "launch",

          name = "Launch Python",

          program = "${file}",
        },

        {
          type = "python",

          request = "attach",

          name = "Attach FastAPI",

          connect = {

            host = "127.0.0.1",

            port = 5678,
          },
        },
      }

      ------------------------------------------------
      -- Go / Gin
      ------------------------------------------------

      require("dap-go").setup()

      dap.configurations.go = {

        {
          type = "go",

          name = "Attach Gin",

          request = "attach",

          mode = "remote",

          host = "127.0.0.1",

          port = 2345,
        },

        {
          type = "go",

          name = "Launch Go",

          request = "launch",

          program = "${file}",
        },
      }

      ------------------------------------------------
      -- JS / TS
      ------------------------------------------------

      require("dap-vscode-js").setup({

        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",

        adapters = {

          "pwa-node",

          "pwa-chrome",
        },
      })

      for _, lang in ipairs({

        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
      }) do
        dap.configurations[lang] = {

          {
            type = "pwa-node",

            request = "launch",

            name = "Launch JS",

            program = "${file}",

            cwd = "${workspaceFolder}",
          },
        }
      end

      ------------------------------------------------
      -- Auto open UI
      ------------------------------------------------

      dap.listeners.after.event_initialized["dapui"] = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated["dapui"] = function()
        dapui.close()
      end

      dap.listeners.before.event_exited["dapui"] = function()
        dapui.close()
      end
    end,
  },
}
