-- space bar leader key
vim.g.mapleader = " "
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- buffer line
vim.keymap.set("n", "<leader>n", ":bn<CR>")
vim.keymap.set("n", "<leader>p", ":bp<CR>")
vim.keymap.set("n", "<leader>x", ":bd<CR>")

-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
-- macOS
-- vim.api.nvim_set_keymap('i', '48;56;212;1064;1908', '', { noremap = true, silent = true })

-- telescope
vim.keymap.set("n", "<leader>ff", require('telescope.builtin').find_files, {})
vim.keymap.set("n", "<leader>fg", require('telescope.builtin').live_grep, {})
vim.keymap.set("n", "<leader>fb", require('telescope.builtin').buffers, {})
vim.keymap.set("n", "<leader>fn", require('telescope.builtin').help_tags, {})
vim.keymap.set("n", "<leader>fs", require('telescope.builtin').current_buffer_fuzzy_find, {})
vim.keymap.set("n", "<leader>fo", require('telescope.builtin').lsp_document_symbols, {})
vim.keymap.set("n", "<leader>fi", require('telescope.builtin').lsp_incoming_calls, {})
vim.keymap.set("n", "<leader>fm", function() require('telescope.builtin').treesitter({symbols= {'function', 'method'}}) end, {})

-- github
vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<CR>")
vim.keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>")

-- quickfix
vim.keymap.set("n", "<leader>qo", ":copen<CR>")
vim.keymap.set("n", "<leader>qf", ":cfirst<CR>")
vim.keymap.set("n", "<leader>ql", ":clast<CR>")
vim.keymap.set("n", "<leader>qn", ":cnext<CR>")
vim.keymap.set("n", "<leader>qp", ":cprev<CR>")
vim.keymap.set("n", "<leader>qc", ":cclose<CR>")

-- Vim REST Console
vim.keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>")

-- LSP
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation)
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>gl", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>gn", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>gp", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>tr", vim.lsp.buf.document_symbol)
vim.keymap.set("i", "<C-Space>", vim.lsp.buf.completion)

-- DEBUGGING
vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
vim.keymap.set("n", "<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<CR>")
vim.keymap.set("n", "<leader>ba", "<cmd>lua require'dap'.list_breakpoints()<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<CR>")
-- DEBUG UI
vim.keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end)
vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end)
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
vim.keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end)
vim.keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')
vim.keymap.set("n", '<leader>de', function() require('telescope.builtin').diagnostics({default_text=":E:"}) end)

-- comment

-- markdown
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>")

vim.keymap.set("n", "<C-/>", function() 
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-/>", function() 
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
vim.keymap.set("v", "<C-/>", ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-_>", function() 
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
vim.keymap.set("i", "<C-_>", function() 
    require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })
vim.keymap.set("v", "<C-_>", ":lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>", { noremap = true, silent = true })


-- MCP Hub
vim.keymap.set("n", "<leader>mh", ":MCPHub<cr>")
