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

  -- Registra o dadbod como source do blink.cmp nos filetypes de SQL.
  -- Sem isto o plugin acima fica instalado mas SEM autocomplete de
  -- tabelas/colunas do banco. Usa o módulo nativo de blink do dadbod.
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        per_filetype = {
          sql = { "dadbod", "snippets", "buffer" },
          mysql = { "dadbod", "snippets", "buffer" },
          plsql = { "dadbod", "snippets", "buffer" },
        },
        providers = {
          dadbod = {
            name = "Dadbod",
            module = "vim_dadbod_completion.blink",
          },
        },
      },
    },
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

      -- Grupo <leader>D (Database). Antes usava <leader>du/da, que colidiam
      -- com o DAP UI / DAP attach do dap.lua.
      {
        "<leader>Du",
        "<cmd>DBUIToggle<CR>",
        desc = "Database UI",
      },

      {
        "<leader>Da",
        "<cmd>DBUIAddConnection<CR>",
        desc = "Add Database",
      },

      {
        "<leader>Df",
        "<cmd>DBUIFindBuffer<CR>",
        desc = "Find DB Buffer",
      },
    },
  },
}
