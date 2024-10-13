return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "folke/trouble.nvim" },
    },
    config = function()
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")
      actions.select_default:replace(function()
        return actions.select_default() + actions.center()
      end)

      local select_one_or_multi = function(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multi = picker:get_multi_selection()
        if not vim.tbl_isempty(multi) then
          require("telescope.actions").close(prompt_bufnr)
          for _, j in pairs(multi) do
            if j.path ~= nil then
              vim.cmd(string.format("%s %s", "edit", j.path))
            end
          end
        else
          require("telescope.actions").select_default(prompt_bufnr)
        end
      end

      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ["<C-h>"] = actions.which_key,
            },
            n = {
              ["<C-h>"] = actions.which_key,
            },
          },
          sorting_strategy = "ascending",
          file_ignore_patterns = { "^%.git$", "node_modules", "build", "dist" },
          path_display = { "absolute" },
          winblend = 5,
          set_env = { ["COLORTERM"] = "truecolor" },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          file_browser = {
            mappings = {
              ["i"] = {
                ["<CR>"] = select_one_or_multi,
              },
              ["n"] = {
                ["<CR>"] = trouble.open,
              },
            },
          },
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- even more opts
            }),
          },
        },
      })

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
        { desc = "Telescope file browser" })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>ft", builtin.buffers, { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "telescope.nvim" },
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
}
