return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
      -- Mason 2.0 removeu Package:get_install_path(). Agora montamos o caminho
      -- direto (mesmo padrão do dap.lua). O codelldb continua sendo instalado
      -- pelo Mason em <data>/mason/packages/codelldb.
      local codelldb = vim.fn.stdpath("data") .. "/mason/packages/codelldb"

      local extension_path = codelldb .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"

      local liblldb = extension_path .. "lldb/lib/liblldb.so"

      vim.g.rustaceanvim = {
        dap = {
          adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb_path, liblldb),
        },
      }
    end,
  },
}
