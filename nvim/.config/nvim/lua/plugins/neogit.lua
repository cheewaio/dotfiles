return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("neogit").setup({
      integration = {
        diffview = true
      },
      kind = "floating",
    })
    vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit" })
    vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "Open Neogit in Diff View" })
    vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>", { desc = "Open Neogit log" })
  end
}
