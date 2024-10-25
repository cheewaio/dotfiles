return {
  "leoluz/nvim-dap-go",
  lazy = true,
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-go").setup({})
  end
}
