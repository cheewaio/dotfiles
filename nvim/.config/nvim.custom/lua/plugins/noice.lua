return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({})
    vim.keymap.set("n", "<leader>nd", ":NoiceDismiss<CR>", { desc = "Dimiss Noice Message" })
  end
}
