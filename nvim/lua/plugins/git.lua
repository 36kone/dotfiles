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
      -- Diff
      ------------------------------------------------------------------

      {
        "<leader>gd",
        function()
          require("gitsigns").diffthis()
        end,
        desc = "Diff",
      },

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
    },
  },

  ------------------------------------------------------------------
  -- DiffView (MAIN solution for ALL merge conflicts)
  ------------------------------------------------------------------

  {

    "sindrets/diffview.nvim",

    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
    },

    keys = {

      -- Main navigation
      {
        "<leader>gv",
        "<cmd>DiffviewOpen<CR>",
        desc = "Open DiffView",
      },

      {
        "<leader>gV",
        "<cmd>DiffviewClose<CR>",
        desc = "Close DiffView",
      },

      -- Merge conflict resolution (key mappings for DiffView)
      {
        "<leader>co",
        "<cmd>DiffviewConflictsChooseOurs<CR>",
        desc = "Choose Ours",
      },

      {
        "<leader>ct",
        "<cmd>DiffviewConflictsChooseTheirs<CR>",
        desc = "Choose Theirs",
      },

      {
        "<leader>cb",
        "<cmd>DiffviewConflictsChooseBoth<CR>",
        desc = "Choose Both",
      },

      {
        "<leader>cn",
        "<cmd>DiffviewConflictsChooseNone<CR>",
        desc = "Choose None",
      },

      {
        "[x",
        "<cmd>DiffviewConflictsPrevious<CR>",
        desc = "Previous Conflict",
      },

      {
        "]x",
        "<cmd>DiffviewConflictsNext<CR>",
        desc = "Next Conflict",
      },
    },

    opts = {
      -- Essential merge tool setup
      view = {
        merge_tool = {
          layout = "diff3_horizontal", -- 3-way merge (ours, theirs, base)
          disable_diagnostics = true, -- Turn off diagnostics while conflicted
          winbar_info = true, -- Show winbar with conflict info
        },
      },
    },
  },
}
