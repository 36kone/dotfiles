return {

  ------------------------------------------------------------------
  -- DiffView
  ------------------------------------------------------------------

  {

    "sindrets/diffview.nvim",

    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
    },

    keys = {

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

      {
        "<leader>gh",
        "<cmd>DiffviewFileHistory %<CR>",
        desc = "Current File History",
      },

      {
        "<leader>gH",
        "<cmd>DiffviewFileHistory<CR>",
        desc = "Repository History",
      },
    },

    opts = {},
  },

  ------------------------------------------------------------------
  -- Git Conflict
  ------------------------------------------------------------------

  {

    "akinsho/git-conflict.nvim",

    version = "*",

    event = "BufReadPre",

    opts = {

      default_mappings = false,

      default_commands = true,

      disable_diagnostics = false,

      list_opener = "copen",
    },

    keys = {

      {
        "<leader>co",
        "<cmd>GitConflictChooseOurs<CR>",
        desc = "Choose Ours",
      },

      {
        "<leader>ct",
        "<cmd>GitConflictChooseTheirs<CR>",
        desc = "Choose Theirs",
      },

      {
        "<leader>cb",
        "<cmd>GitConflictChooseBoth<CR>",
        desc = "Choose Both",
      },

      {
        "<leader>cn",
        "<cmd>GitConflictChooseNone<CR>",
        desc = "Choose None",
      },

      {
        "]x",
        "<cmd>GitConflictNextConflict<CR>",
        desc = "Next Conflict",
      },

      {
        "[x",
        "<cmd>GitConflictPrevConflict<CR>",
        desc = "Previous Conflict",
      },
    },
  },

  ------------------------------------------------------------------
  -- Fugitive
  ------------------------------------------------------------------

  {

    "tpope/vim-fugitive",

    cmd = {
      "Git",
      "G",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gblame",
    },

    keys = {

      {
        "<leader>gg",
        "<cmd>Git<CR>",
        desc = "Git",
      },

      {
        "<leader>gm",
        "<cmd>Gvdiffsplit!<CR>",
        desc = "3-Way Merge",
      },

      {
        "<leader>gb",
        "<cmd>Gblame<CR>",
        desc = "Git Blame",
      },
    },
  },
}
