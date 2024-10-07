return {
  "rcarriga/nvim-dap-ui",
  lazy = true,
  event = "BufRead",
  dependencies = {
    { "mfussenegger/nvim-dap", lazy = true },
    { "nvim-neotest/nvim-nio", lazy = true },
    {
      "mxsdev/nvim-dap-vscode-js",
      dependencies = {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
      },
      config = function()
        require("dap-vscode-js").setup({
          -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
          -- debugger_cmd = { "extension" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
          adapters = {
            "chrome",
            "pwa-node",
            "pwa-chrome",
            "pwa-msedge",
            "node-terminal",
            "pwa-extensionHost",
            "node",
            "chrome",
          }, -- which adapters to register in nvim-dap
          -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
          -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
          -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
        })
      end,
    },
  },
  config = function()
    require("dapui").setup()
    local js_based_languages = { "typescript", "javascript", "typescriptreact" }

    for _, language in ipairs(js_based_languages) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'Start Chrome with "localhost"',
          url = "http://localhost:3000",
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
        },
      }
    end

    require('dap.ext.vscode').load_launchjs(nil,
      {
        ['pwa-node'] = js_based_languages,
        ['node'] = js_based_languages,
        ['chrome'] = js_based_languages,
        ['pwa-chrome'] = js_based_languages
      }
    )
  end,
  keys = {
    { "<leader>d", "", desc = "  Debug" },
    { "<leader>dt", function() require 'dap'.toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>db", function() require 'dap'.step_back() end, desc = "Step Back" },
    { "<leader>dc", function() require 'dap'.continue() end, desc = "Continue" },
    { "<leader>dC", function() require 'dap'.run_to_cursor() end, desc = "Run To Cursor" },
    { "<leader>dd", function() require 'dap'.disconnect() end, desc = "Disconnect" },
    { "<leader>dg", function() require 'dap'.session() end, desc = "Get Session" },
    { "<leader>di", function() require 'dap'.step_into() end, desc = "Step Into" },
    { "<leader>do", function() require 'dap'.step_over() end, desc = "Step Over" },
    { "<leader>du", function() require 'dap'.step_out() end, desc = "Step Out" },
    { "<leader>dp", function() require 'dap'.pause() end, desc = "Pause" },
    { "<leader>dr", function() require 'dap'.repl.toggle() end, desc = "Toggle Repl" },
    { "<leader>ds", function() require 'dap'.continue() end, desc = "Start" },
    { "<leader>dq", function() require 'dap'.close() end, desc = "Quit" },
    { "<leader>dU", function() require 'dapui'.toggle({ reset = true }) end, desc = "Toggle UI" },
  },
}
