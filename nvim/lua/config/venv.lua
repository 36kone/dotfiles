-- Auto-ativação de virtualenv (Python).
--
-- Ao abrir o Neovim (e ao trocar de diretório com :cd), procura um venv
-- na raiz do projeto e "ativa" replicando o que `source bin/activate` faz:
--   1) VIRTUAL_ENV = <venv>
--   2) PATH        = <venv>/bin:$PATH   (prioridade pro python/ruff do venv)
--   3) PYTHONHOME  = unset
--
-- Com o bin/ do venv no PATH, o pyright/ruff e o :terminal passam a usar
-- automaticamente o interpretador e os pacotes do projeto — sem precisar
-- ativar o venv no shell antes de abrir o nvim.
--
-- Obs: focado em Unix (Linux/macOS), que usa `bin/`. No Windows seria `Scripts/`.

local uv = vim.uv or vim.loop

local M = {}

-- Nomes de diretório mais comuns, em ordem de preferência (caminho rápido).
local VENV_DIRS = { ".venv", "venv", "env" }

-- Marcadores de raiz de projeto: a partir daqui é que a gente varre por venvs
-- com nome arbitrário (ex: uv/virtualenv criando "impacto-network-service").
local ROOT_MARKERS = { "pyproject.toml", ".git", "setup.py", "setup.cfg", "requirements.txt" }

-- PATH original, sem nenhum venv na frente. Serve de base pra nunca empilhar
-- caminhos ao reativar (troca de projeto).
local ORIGINAL_PATH = vim.env.PATH
-- VIRTUAL_ENV herdado do shell (direnv, `uv run`, etc.), capturado uma única
-- vez. Só é honrado na 1ª ativação — depois quem manda é a detecção por projeto.
local EXTERNAL_VENV = vim.env.VIRTUAL_ENV
local active = nil

-- Confirma que o diretório é de fato um venv (e não uma pasta qualquer
-- chamada "env"). pyvenv.cfg é o marcador moderno; bin/activate cobre venvs
-- antigos (virtualenv).
local function is_venv(dir)
  return uv.fs_stat(dir .. "/pyvenv.cfg") ~= nil or uv.fs_stat(dir .. "/bin/activate") ~= nil
end

-- Sobe a partir de `start` até achar a raiz do projeto (ou devolve o próprio
-- start se não achar marcador).
local function project_root(start)
  local marker = vim.fs.find(ROOT_MARKERS, { path = start, upward = true, limit = 1 })[1]
  return marker and vim.fs.dirname(marker) or start
end

-- Varre as subpastas imediatas de `dir` procurando qualquer uma que seja um
-- venv (via pyvenv.cfg). É isso que pega o venv com nome do projeto, criado
-- pelo uv/virtualenv — o nome da pasta não importa, só o conteúdo.
local function scan_for_venv(dir)
  local fd = uv.fs_scandir(dir)
  if not fd then
    return
  end
  while true do
    local name, typ = uv.fs_scandir_next(fd)
    if not name then
      break
    end
    if typ == "directory" then
      local candidate = dir .. "/" .. name
      if is_venv(candidate) then
        return candidate
      end
    end
  end
end

-- Procura um venv para o diretório `start`.
local function find_venv(start)
  -- Na 1ª ativação, respeita um VIRTUAL_ENV herdado do shell.
  if active == nil and EXTERNAL_VENV and is_venv(EXTERNAL_VENV) then
    return EXTERNAL_VENV
  end

  local root = project_root(start)

  -- 1) nomes comuns na raiz (caminho rápido).
  for _, name in ipairs(VENV_DIRS) do
    local dir = root .. "/" .. name
    if is_venv(dir) then
      return dir
    end
  end

  -- 2) fallback: qualquer subpasta da raiz que seja venv (nome arbitrário).
  return scan_for_venv(root)
end

local function deactivate()
  if not active then
    return
  end
  vim.env.PATH = ORIGINAL_PATH
  vim.env.VIRTUAL_ENV = nil
  active = nil
end

local function activate(venv)
  if active == venv then
    return
  end
  deactivate()
  vim.env.VIRTUAL_ENV = venv
  vim.env.PATH = venv .. "/bin:" .. ORIGINAL_PATH
  vim.env.PYTHONHOME = nil
  active = venv
  vim.schedule(function()
    vim.notify("venv ativado: " .. vim.fn.fnamemodify(venv, ":~:."), vim.log.levels.INFO)
  end)
end

local function detect()
  local cwd = uv.cwd()
  local venv = cwd and find_venv(cwd) or nil
  if venv then
    activate(venv)
  else
    deactivate()
  end
end

function M.setup()
  detect() -- imediato, no startup (antes do pyright/ruff subirem)
  vim.api.nvim_create_autocmd("DirChanged", {
    group = vim.api.nvim_create_augroup("user_venv", { clear = true }),
    callback = detect,
    desc = "Reativa o venv ao trocar de diretório",
  })
end

return M
