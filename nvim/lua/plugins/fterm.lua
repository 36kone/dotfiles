return {

  -------------------------------------------------
  -- FTerm.nvim
  -------------------------------------------------
  -- Terminal flutuante leve. Alterna com <A-i> tanto no modo normal
  -- quanto de dentro do terminal (modo terminal).
  {
    "numToStr/FTerm.nvim",

    keys = {

      {
        "<A-i>",
        function()
          require("FTerm").toggle()
        end,
        mode = "n",
        desc = "Toggle FTerm",
      },

      {
        "<A-i>",
        function()
          require("FTerm").toggle()
        end,
        mode = "t",
        desc = "Toggle FTerm",
      },
    },

    opts = {
      border = "rounded",

      dimensions = {
        height = 0.6,
        width = 0.8,
      },
    },
  },
}
