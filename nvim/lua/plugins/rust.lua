return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    config = function()
      local mason_registry = require("mason-registry")

      local codelldb = mason_registry.get_package("codelldb"):get_install_path()

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
