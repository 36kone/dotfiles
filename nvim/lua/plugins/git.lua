return {

  -------------------------------------------------
  -- Gitsigns
  -------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",

    event = {
      "BufReadPre",
      "BufNewFile",
    },

    opts = {

      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },

      current_line_blame = false,

      current_line_blame_opts = {
        delay = 500,
      },

      preview_config = {
        border = "rounded",
      },
    },

    keys = {

      ------------------------------------------------------------------
      -- Hunks
      ------------------------------------------------------------------

      {
        "]h",
        function()
          require("gitsigns").nav_hunk("next")
        end,
        desc = "Next Hunk",
      },

      {
        "[h",
        function()
          require("gitsigns").nav_hunk("prev")
        end,
        desc = "Previous Hunk",
      },

      {
        "<leader>gp",
        function()
          require("gitsigns").preview_hunk()
        end,
        desc = "Preview Hunk",
      },

      ------------------------------------------------------------------
      -- Stage
      ------------------------------------------------------------------

      {
        "<leader>gs",
        function()
          require("gitsigns").stage_hunk()
        end,
        desc = "Stage Hunk",
      },

      {
        "<leader>gu",
        function()
          require("gitsigns").undo_stage_hunk()
        end,
        desc = "Undo Stage Hunk",
      },

      {
        "<leader>gr",
        function()
          require("gitsigns").reset_hunk()
        end,
        desc = "Reset Hunk",
      },

      {
        "<leader>gS",
        function()
          require("gitsigns").stage_buffer()
        end,
        desc = "Stage Buffer",
      },

      {
        "<leader>gR",
        function()
          require("gitsigns").reset_buffer()
        end,
        desc = "Reset Buffer",
      },

      ------------------------------------------------------------------
      -- Diff
      ------------------------------------------------------------------

      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Diff",
      },

      -- Fecha o diff SEM deixar o buffer preso em modo diff.
      -- `:close` sozinho mantém diff/foldmethod=diff/scrollbind ligados,
      -- o que faz o arquivo parecer "quebrado" (tudo colapsado em fold)
      -- e atrapalha a navegação. Aqui a gente:
      --   1) roda diffoff! -> restaura wrap/fold/scrollbind do buffer
      --   2) fecha as janelas scratch do gitsigns (gitsigns://...)
      -- Dentro do diff, use `]c`/`[c` p/ navegar e `do` p/ puxar a
      -- mudança do lado direito (index) de volta pro seu arquivo.
      {
        "<leader>gD",
        function()
          vim.cmd("diffoff!")
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            local buf = vim.api.nvim_win_get_buf(win)
            local name = vim.api.nvim_buf_get_name(buf)
            if name:match("^gitsigns:") then
              vim.api.nvim_win_close(win, true)
            end
          end
        end,
        desc = "Close Diff",
      },

      ------------------------------------------------------------------
      -- Blame
      ------------------------------------------------------------------

      {
        "<leader>gb",
        function()
          require("gitsigns").blame_line()
        end,
        desc = "Blame Line",
      },

      {
        "<leader>gB",
        function()
          require("gitsigns").toggle_current_line_blame()
        end,
        desc = "Toggle Blame",
      },

      ------------------------------------------------------------------
      -- Deleted
      ------------------------------------------------------------------

      {
        "<leader>gi",
        function()
          require("gitsigns").preview_hunk_inline()
        end,
        desc = "Inline Preview",
      },
    },
  },

  -------------------------------------------------
  -- Snacks
  -------------------------------------------------

  {
    "folke/snacks.nvim",

    opts = {

      gitbrowse = {
        enabled = true,
      },

      picker = {
        enabled = true,
      },
    },

    keys = {

      {
        "<leader>go",
        function()
          require("snacks").gitbrowse()
        end,
        desc = "Open Remote",
      },

      {
        "<leader>gl",
        function()
          require("snacks").picker.git_log()
        end,
        desc = "Git Log",
      },

      {
        "<leader>gf",
        function()
          require("snacks").picker.git_files()
        end,
        desc = "Git Files",
      },

      {
        "<leader>gc",
        function()
          require("snacks").picker.git_status()
        end,
        desc = "Git Status",
      },
    },
  },

  -------------------------------------------------
  -- Gitlinker
  -------------------------------------------------

  {
    "ruifm/gitlinker.nvim",

    dependencies = {
      "nvim-lua/plenary.nvim",
    },

    opts = {},

    keys = {

      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("n", {
            action = "copy",
          })
        end,
        desc = "Copy Git Link",
      },

      {
        "<leader>gy",
        function()
          require("gitlinker").get_buf_range_url("v", {
            action = "copy",
          })
        end,
        mode = "v",
        desc = "Copy Selected Git Link",
      },
    },
  },
}
