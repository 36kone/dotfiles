return {

  -------------------------------------------------
  -- persistence.nvim (auto-restaurar sessão)
  -------------------------------------------------
  -- O persistence já vem no LazyVim e salva a sessão por diretório ao sair.
  -- Aqui só ligamos o restaurar automático: ao abrir o Neovim sem arquivo
  -- (só `nvim`) OU passando um diretório (`nvim .`, `nvim ~/proj`), ele
  -- reabre a última sessão daquele projeto.
  -- Restauração manual continua valendo: <leader>qs / <leader>ql / <leader>qS.
  {
    "folke/persistence.nvim",

    opts = {},

    init = function()
      -- Marca quando o Neovim recebeu dados por stdin (ex.: `cmd | nvim -`),
      -- pra não restaurar sessão por cima desse conteúdo.
      vim.api.nvim_create_autocmd("StdinReadPre", {
        callback = function()
          vim.g.started_with_stdin = true
        end,
      })

      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          if vim.g.started_with_stdin then
            return
          end

          local argc = vim.fn.argc()

          -- Restaura quando:
          --   nvim            -> sem argumento (argc == 0)
          --   nvim .  / dir   -> único argumento e é um diretório
          -- Assim `nvim arquivo.py` segue abrindo só o arquivo.
          local restore = argc == 0
            or (argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1)

          if restore then
            -- Adia pro fim do startup: aí o lazy.nvim já registrou os handlers
            -- de LazyFile, então os buffers restaurados disparam o carregamento
            -- de treesitter/LSP e o highlight liga corretamente.
            vim.schedule(function()
              require("persistence").load()
            end)
          end
        end,
      })
    end,
  },
}
