return {
  -- Garante os language servers via nvim-lspconfig.
  -- No LazyVim, tudo que for listado em `opts.servers` é instalado
  -- automaticamente pelo Mason (mason-lspconfig).
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- Desliga o hover do ruff: quem responde hover no Python é o pyright.
      -- (Sem isso, os dois disputam e o hover fica inconsistente.)
      setup = {
        ruff = function()
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "ruff" then
                client.server_capabilities.hoverProvider = false
              end
            end,
          })
        end,
      },
      servers = {
        -- Python: pyright (type-checking rápido e preciso).
        -- Melhor que o python-lsp-server (pylsp) hoje em dia.
        pyright = {},

        -- Ruff como LSP: expõe os warnings de lint (E/F/UP/B/SIM/RUF) do
        -- pyproject.toml como diagnostics + code actions de autofix.
        -- pyright cuida dos tipos; ruff cuida de lint. Ver o on_attach
        -- abaixo, que desliga o hover do ruff pra não conflitar com o pyright.
        ruff = {},

        -- Go
        gopls = {},

        -- TypeScript / JavaScript / React (jsx/tsx).
        -- vtsls é o cliente padrão do LazyVim e cobre React sem server extra.
        vtsls = {},

        -- ESLint: lint + autofix pro TS/JS/React (o prettierd só formata).
        -- Complementa o vtsls, igual o ruff complementa o pyright no Python.
        eslint = {},

        -- Front-end
        cssls = {}, -- CSS / SCSS / LESS
        html = {}, -- HTML
        tailwindcss = {}, -- Tailwind (classes utilitárias)

        -- Rust NÃO entra aqui: o rust_analyzer é gerenciado pelo
        -- rustaceanvim (ver lua/plugins/rust.lua). Declarar aqui causaria
        -- dois clientes LSP anexados ao mesmo buffer.
      },
    },
  },

  -- Reforça a instalação das ferramentas no Mason (idempotente).
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "gopls",
        "vtsls",
        "eslint-lsp",
        "css-lsp",
        "html-lsp",
        "tailwindcss-language-server",
      })
    end,
  },
}
