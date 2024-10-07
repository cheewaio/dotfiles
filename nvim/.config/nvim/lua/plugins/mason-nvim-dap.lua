return {
  "jay-babu/mason-nvim-dap.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
  },
  config = function()
    require("mason-nvim-dap").setup({
      ensure_installed = { "python", "delve", "node2", "chrome", "js", "javadb", "javatest" }
    })
  end
}
