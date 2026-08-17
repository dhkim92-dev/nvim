local opts = { buffer = true, silent = true }

vim.keymap.set("n", "<leader>mp", "<cmd>MermaidPreview<CR>",
  vim.tbl_extend("force", opts, { desc = "Mermaid Preview" }))
vim.keymap.set("n", "<leader>mf", "<cmd>MermaidFormat<CR>",
  vim.tbl_extend("force", opts, { desc = "Mermaid Format" }))
vim.keymap.set("n", "<leader>mr", "<cmd>MermaidRender<CR>",
  vim.tbl_extend("force", opts, { desc = "Mermaid Render" }))
vim.keymap.set("n", "<leader>mc", "<cmd>MermaidCopyURL<CR>",
  vim.tbl_extend("force", opts, { desc = "Mermaid Copy URL" }))
vim.keymap.set("n", "<leader>mx", "<cmd>MermaidPreviewStop<CR>",
  vim.tbl_extend("force", opts, { desc = "Mermaid Stop Preview" }))
