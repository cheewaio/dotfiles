return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        bash = { "beautysh" },
        css = { "prettierd", "prettier" },
        go = { "goimports", "gofmt" },
        json = { "prettier" },
        javascript = { "prettier" },
        lua = { "stylua" },
        python = { "prettier" },
        scss = { "prettierd", "prettier" },
        sh = { "shellcheck" },
        terraform = { "terraform_fmt" },
        typescript = { "prettier" },
        yaml = { "prettier" },
      },
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        require("conform").format({ bufnr = args.buf })
      end,
    })
    vim.keymap.set({ "n", "v" }, "<leader>cf", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
