return {

  -------------------------------------------------
  -- Comment.nvim
  -------------------------------------------------
  -- Comentários por linha/bloco com suporte a treesitter.
  -- Mapeamentos padrão:
  --   gcc  -> alterna comentário na linha
  --   gbc  -> alterna comentário em bloco
  --   gc   -> operador (normal + visual): gcap, gcj, gc em seleção
  --   gcO / gco / gcA -> comenta acima/abaixo/fim de linha
  {
    "numToStr/Comment.nvim",

    event = "VeryLazy",

    opts = {},
  },
}
