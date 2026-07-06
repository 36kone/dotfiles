local selected_theme = "tokyonight"

return {
  {
    "TheNiteCoder/mountaineer.vim",
    lazy = false,
    priority = 1000,
  },

  {
    "k4yt3x/ayu-vim-darker",
    lazy = false,
    priority = 1000,
    init = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"

      -- versão mais dark do ayu
      vim.g.ayucolor = "darker"
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = selected_theme,
    },
  },
}
