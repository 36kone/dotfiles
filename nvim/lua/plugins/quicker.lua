return {
  {
    "stevearc/quicker.nvim",

    event = "FileType qf",

    opts = {},

    keys = {
      {
        "<leader>q",
        function()
          require("quicker").toggle()
        end,
        desc = "Toggle quickfix",
      },
    },

    -- >/< só valem DENTRO do quickfix (buffer-local). Antes estavam no `keys`
    -- do lazy, viravam keymaps globais e sequestravam o operador de
    -- indentação `>`/`<`/`>>`/`<<` no editor inteiro.
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function(args)
          vim.keymap.set("n", ">", function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end, { buffer = args.buf, desc = "Expand quickfix context" })

          vim.keymap.set("n", "<", function()
            require("quicker").collapse()
          end, { buffer = args.buf, desc = "Collapse quickfix context" })
        end,
      })
    end,
  },
}
