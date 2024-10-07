return {
  {
    "akinsho/bufferline.nvim",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              separator = true,
            },
          },
          diagnostics = "nvim_lsp",
          indicator = {
            icon = "  ", -- this should be omitted if indicator style is not "icon"
            style = "icon",
          }
        }
      })
      vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Buffer" })
      vim.keymap.set("n", "<s-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Buffer" })
      vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete Buffer and Window" })
    end
  }
}
