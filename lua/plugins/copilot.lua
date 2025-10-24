return {
  "github/copilot.vim",
  event = "VeryLazy",
  config = function()
    -- Copilot 자동 시작
    vim.g.copilot_no_tab_map = false -- Tab 키 충돌 방지
    -- vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
  end
}

