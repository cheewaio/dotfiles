return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- normal mode
        n = {
          ["<C-\\>"] = { "<Cmd>ToggleTerm direction=float<CR>", desc = "Toggle floating terminal" },
          ["<Leader>gv"] = { "<Cmd>DiffviewOpen<CR>", desc = "Open Git Diff View" },
          ["<Leader>gV"] = { "<Cmd>DiffviewClose<CR>", desc = "Close Git Diff View" },
        },
        -- insert mode
        i = {
          ["<C-\\>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggl terminal" },
        },
        -- terminal mode
        t = {
          ["<C-\\>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>lo"] = {
            "<Cmd>Telescope lsp_document_symbols ignore_symbols=variable,property<CR>",
            desc = "Find LSP Outline",
          },
        },
      },
    },
  },
}
