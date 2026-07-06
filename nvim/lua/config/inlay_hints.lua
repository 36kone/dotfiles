local M = {}

function M.enable_inlay_hints(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)

  if not client then
    return
  end

  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, {
      bufnr = event.buf,
    })
  end
end

return M
