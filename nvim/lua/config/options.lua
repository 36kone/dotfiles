-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Ativa automaticamente o virtualenv do projeto (ver lua/config/venv.lua).
-- Rodado aqui de propósito: options.lua carrega antes do lazy/LSP, então o
-- pyright/ruff já sobem enxergando o PATH/VIRTUAL_ENV do venv.
require("config.venv").setup()
