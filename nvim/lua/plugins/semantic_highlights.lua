local palette = {
  parameter = "#56A8F5", -- Azul (JetBrains)
  property = "#9876AA", -- Roxo
  function_ = "#DCDCAA", -- Amarelo
  class = "#4EC9B0", -- Verde água
  namespace = "#C586C0", -- Roxo claro
  constant = "#4FC1FF", -- Azul claro
  enum = "#4EC9B0",
}

local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

local function apply()
  ---------------------------------------------------------------------------
  -- Treesitter
  ---------------------------------------------------------------------------

  hl("@variable.parameter", { fg = palette.parameter })

  hl("@property", { fg = palette.property })
  hl("@variable.member", { fg = palette.property })

  hl("@function", { fg = palette.function_ })
  hl("@function.call", { fg = palette.function_ })

  hl("@method", { fg = palette.function_ })
  hl("@method.call", { fg = palette.function_ })

  hl("@constructor", { fg = palette.class })

  ---------------------------------------------------------------------------
  -- Semantic Tokens (todos os LSPs)
  ---------------------------------------------------------------------------

  hl("@lsp.type.parameter", { link = "@variable.parameter" })

  hl("@lsp.type.property", { link = "@property" })

  hl("@lsp.type.method", { link = "@method" })
  hl("@lsp.type.function", { link = "@function" })

  hl("@lsp.type.class", { fg = palette.class })
  hl("@lsp.type.enum", { fg = palette.enum })
  hl("@lsp.type.namespace", { fg = palette.namespace })

  hl("@lsp.type.enumMember", { fg = palette.constant })

  ---------------------------------------------------------------------------
  -- Modificadores (o grande diferencial)
  ---------------------------------------------------------------------------

  hl("@lsp.mod.readonly", { fg = palette.constant })

  hl("@lsp.mod.defaultLibrary", {
    italic = true,
  })

  hl("@lsp.mod.documentation", {
    italic = true,
  })

  hl("@lsp.mod.modification", {})

  hl("@lsp.mod.async", {
    italic = true,
  })

  ---------------------------------------------------------------------------
  -- Rust
  ---------------------------------------------------------------------------

  hl("@lsp.type.macro", {
    fg = palette.function_,
  })

  ---------------------------------------------------------------------------
  -- Go
  ---------------------------------------------------------------------------

  hl("@lsp.type.interface", {
    fg = palette.class,
  })

  ---------------------------------------------------------------------------
  -- TypeScript
  ---------------------------------------------------------------------------

  hl("@lsp.type.typeParameter", {
    fg = palette.parameter,
  })
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = apply,
})

apply()

return {}
