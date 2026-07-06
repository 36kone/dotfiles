return {

  -------------------------------------------------
  -- Dadbod
  -------------------------------------------------

  {
    "tpope/vim-dadbod",

    lazy = true,
  },

  -------------------------------------------------
  -- Completion SQL
  -------------------------------------------------

  {
    "kristijanhusak/vim-dadbod-completion",

    ft = {
      "sql",
      "mysql",
      "plsql",
      "postgres",
    },

    lazy = true,
  },

  -------------------------------------------------
  -- Dadbod UI
  -------------------------------------------------

  {
    "kristijanhusak/vim-dadbod-ui",

    dependencies = {

      "tpope/vim-dadbod",

      "kristijanhusak/vim-dadbod-completion",
    },

    cmd = {

      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },

    init = function()
      vim.g.db_ui_use_nerd_fonts = 1

      vim.g.db_ui_show_database_icon = 1

      vim.g.db_ui_force_echo_notifications = 1

      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"

      vim.g.db_ui_execute_on_save = false

      vim.g.db_ui_use_nvim_notify = true
    end,

    keys = {

      {
        "<leader>du",
        "<cmd>DBUIToggle<CR>",
        desc = "Database UI",
      },

      {
        "<leader>da",
        "<cmd>DBUIAddConnection<CR>",
        desc = "Add Database",
      },

      {
        "<leader>df",
        "<cmd>DBUIFindBuffer<CR>",
        desc = "Find DB Buffer",
      },
    },
  },
}
