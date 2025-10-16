-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Testing keymaps (Neotest)
map("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run nearest test" })
map("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = "Run file tests" })
map("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Toggle test summary" })
map("n", "<leader>to", "<cmd>lua require('neotest').output.open({ enter = true })<cr>", { desc = "Show test output" })
map("n", "<leader>tO", "<cmd>lua require('neotest').output_panel.toggle()<cr>", { desc = "Toggle output panel" })
map("n", "<leader>tS", "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop test" })
map("n", "<leader>tw", "<cmd>lua require('neotest').watch.toggle()<cr>", { desc = "Toggle watch mode" })

-- Debugging keymaps (DAP)
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
map("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = "Conditional breakpoint" })
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<cr>", { desc = "Continue" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<cr>", { desc = "Step into" })
map("n", "<leader>do", "<cmd>lua require('dap').step_over()<cr>", { desc = "Step over" })
map("n", "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", { desc = "Step out" })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", { desc = "Toggle REPL" })
map("n", "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", { desc = "Run last" })
map("n", "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", { desc = "Terminate" })

-- Filetype-specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    map("n", "<leader>cgt", "<cmd>GoAddTag<cr>", { desc = "Add struct tags", buffer = true })
    map("n", "<leader>cgT", "<cmd>GoRmTag<cr>", { desc = "Remove struct tags", buffer = true })
    map("n", "<leader>cgi", "<cmd>GoImpl<cr>", { desc = "Implement interface", buffer = true })
    map("n", "<leader>cge", "<cmd>GoIfErr<cr>", { desc = "Add if err", buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function()
    map("n", "<leader>ctc", "<cmd>TSC<cr>", { desc = "TypeScript compiler check", buffer = true })
  end,
})
