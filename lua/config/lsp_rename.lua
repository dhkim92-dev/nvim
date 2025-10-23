-- ~/.config/nvim/lua/config/lsp_rename.lua
local M = {}

-- 유틸: 현재 버퍼에서 트리시터가 있는지 확인, parser 반환
local function get_ts_parser(bufnr)
  local ok, ts = pcall(require, "vim.treesitter")
  if not ok or not ts then return nil end
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr)
  return parser
end

-- 유틸: 노드 타입 이름
local function node_type(node) if not node then return nil end return node:type() end

-- 주 노드에서 부모로 올라가며 'class'/'object'/'function' 등 스코프 노드를 찾음
local function find_enclosing_scope_node(node)
  if not node then return nil end
  local cur = node
  while cur do
    local t = node_type(cur)
    if t == "class_declaration"
      or t == "object_declaration"
      or t == "class_body"
      or t == "declaration"
      or t == "function_declaration"
      or t == "function"
      or t == "file"
      or t == "source_file" then
      return cur
    end
    cur = cur:parent()
  end
  return nil
end

-- 트리시터로 현재 커서가 위치한 identifier 노드 가져오기
local function get_node_at_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = get_ts_parser(bufnr)
  if not parser then return nil end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  row = row - 1
  local tree = parser:parse()[1]
  if not tree then return nil end
  local root = tree:root()
  return root:named_descendant_for_range(row, col, row, col)
end

-- 주어진 node의 범위(1-based 라인 번호) 반환
local function get_node_range_lines(node)
  if not node then return nil end
  local srow, scol, erow, ecol = node:range()
  return srow + 1, erow + 1
end

-- 안전한 범위 내 치환 (confirm 모드)
local function replace_in_range(bufnr, start_line, end_line, word, new_word)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  -- build substitution command with \v and \< \> for word boundary; use c flag to confirm each
  local esc_word = word:gsub("([%%%-%^%$%(%)%[%]%+%*%?%.])", "%%%1")
  local pattern = "\\<" .. esc_word .. "\\>"
  local cmd = string.format("%d,%ds/%s/%s/gc", start_line, end_line, pattern, new_word)
  vim.cmd(cmd)
end

-- 최종 스마트 리네임 함수 (LSP 우선, 실패시 fallback)
function M.smart_rename()
  local current_word = vim.fn.expand("<cword>")
  if current_word == nil or current_word == "" then
    print("[smart_rename] No symbol under cursor")
    return
  end

  -- 먼저 LSP prepareRename 시도 (synchronous)
  local params = vim.lsp.util.make_position_params()
  local ok, prepare = pcall(vim.lsp.buf_request_sync, 0, "textDocument/prepareRename", params, 500)
  if ok and prepare and next(prepare) ~= nil then
    -- LSP가 rename 지원/허용함 -> 그냥 LSP rename 사용
    vim.ui.input({ prompt = "New name: ", default = current_word }, function(new_name)
      if not new_name or new_name == "" or new_name == current_word then
        print("[smart_rename] Cancelled")
        return
      end
      vim.lsp.buf.rename(new_name)
    end)
    return
  end

  -- LSP 준비 안 됨 또는 prepareRename 실패 -> fallback
  -- 트리시터 노드 범위 찾아서 그 내부에서만 치환
  local node = get_node_at_cursor()
  local start_line, end_line = nil, nil
  if node then
    local scope_node = find_enclosing_scope_node(node)
    if scope_node then
      start_line, end_line = get_node_range_lines(scope_node)
    end
  end

  -- 트리시터 없거나 scope 못 찾으면 file 범위로 fallback (그러나 confirm 모드라 안전)
  if not start_line or not end_line then
    start_line = 1
    end_line = vim.api.nvim_buf_line_count(0)
  end

  -- 입력 받고 치환 (confirm mode)
  vim.ui.input({ prompt = "Rename (local) to: ", default = current_word }, function(new_name)
    if not new_name or new_name == "" or new_name == current_word then
      print("[smart_rename] Cancelled")
      return
    end
    replace_in_range(0, start_line, end_line, current_word, new_name)
    print(string.format("[smart_rename] Replaced '%s' -> '%s' in lines %d..%d (confirm applied)", current_word, new_name, start_line, end_line))
  end)
end

return M
