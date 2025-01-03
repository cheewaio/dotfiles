return {
  "leoluz/nvim-dap-go",
  lazy = false,
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-go").setup({})
  end
}
