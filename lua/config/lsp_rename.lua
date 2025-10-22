-- ~/.config/nvim/lua/config/lsp_rename.lua

-- 단축키: <leader>rn
-- 커서 심볼 rename (Java + Kotlin 모두 적용)
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua require("config.lsp_rename").rename_symbol()<CR>', { noremap = true, silent = true })

local M = {}

function M.rename_symbol()
    -- 현재 LSP가 attach 되어 있는지 확인
    local clients = vim.lsp.get_active_clients({bufnr = 0})
    if #clients == 0 then
        print("[WARN] LSP not attached to this buffer")
        return
    end

    -- rename 요청
    vim.ui.input({prompt = 'New name: '}, function(input)
        if not input or input == "" then
            print("[INFO] Rename canceled")
            return
        end

        vim.lsp.buf.rename(input)
        print("[INFO] Rename requested: " .. input)
    end)
end

return M
