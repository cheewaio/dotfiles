if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "go",
      "html",
      "javascript",
      "json",
      "lua",
      "python",
      "typescript",
      "yaml",
      "vim",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
