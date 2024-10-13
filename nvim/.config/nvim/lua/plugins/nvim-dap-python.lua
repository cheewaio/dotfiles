return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = { "mfussenegger/nvim-dap" },
  config = function()
    require("dap-python").setup("$HOME/dev/venv/bin/python")
  end
}
