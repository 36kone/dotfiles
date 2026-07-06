return {
  {
    "tpope/vim-dotenv",
    ft = "dotenv",
    init = function()
      vim.filetype.add({
        filename = {
          [".env"] = "dotenv",
          [".env.local"] = "dotenv",
          [".env.development"] = "dotenv",
          [".env.production"] = "dotenv",
          [".env.test"] = "dotenv",
          [".env.example"] = "dotenv",
        },
      })
    end,
  },
}
