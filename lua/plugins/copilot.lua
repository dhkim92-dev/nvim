return {
  "github/copilot.vim",
  event = "VeryLazy",
  -- event = "InsertEnter",
  config = function()
    -- Copilot 자동 시작
    vim.g.copilot_no_tab_map = false -- Tab 키 충돌 방지
    -- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  -- config = function()
    -- vim.g.copilot_no_tab_map = true
    -- vim.api.nvim_set_keymap(
      -- "i",
      -- "<C-Space>",
      -- 'copilot#Accept("<CR>")',
      -- {silent = true, expr = true}
    -- )
    -- 자동으로 표시(자동완성처럼)
    vim.g.copilot_autocomplete = true
  end,
}

