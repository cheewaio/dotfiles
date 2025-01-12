-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                     ]],
        [[       ████ ██████           █████      ██                     ]],
        [[      ███████████             █████                             ]],
        [[      █████████ ███████████████████ ███   ███████████   ]],
        [[     █████████  ███    █████████████ █████ ██████████████   ]],
        [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        [[                                                                       ]],
        [[                                                                       ]],
        [[                                                                       ]],
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.on_attach = function(bufnr)
        local astrocore = require "astrocore"
        local get_icon = require("astroui").get_icon
        local prefix, maps = "<Leader>g", astrocore.empty_map_table()
        for _, mode in ipairs { "n", "v" } do
          maps[mode][prefix] = { desc = get_icon("Git", 1, true) .. "Git" }
        end

        maps.n[prefix .. "B"] =
          { function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle Git current line blame" }
        maps.n[prefix .. "l"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
        maps.n[prefix .. "L"] =
          { function() require("gitsigns").blame_line { full = true } end, desc = "View full Git blame" }
        maps.n[prefix .. "p"] = { function() require("gitsigns").preview_hunk_inline() end, desc = "Preview Git hunk" }
        maps.n[prefix .. "r"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
        maps.v[prefix .. "r"] = {
          function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          desc = "Reset Git hunk",
        }
        maps.n[prefix .. "R"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
        maps.n[prefix .. "s"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
        maps.v[prefix .. "s"] = {
          function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end,
          desc = "Stage Git hunk",
        }
        maps.n[prefix .. "S"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
        maps.n[prefix .. "u"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
        -- maps.n[prefix .. "d"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }

        maps.n["[G"] = { function() require("gitsigns").nav_hunk "first" end, desc = "First Git hunk" }
        maps.n["]G"] = { function() require("gitsigns").nav_hunk "last" end, desc = "Last Git hunk" }
        maps.n["]g"] = { function() require("gitsigns").nav_hunk "next" end, desc = "Next Git hunk" }
        maps.n["[g"] = { function() require("gitsigns").nav_hunk "prev" end, desc = "Previous Git hunk" }
        for _, mode in ipairs { "o", "x" } do
          maps[mode]["ig"] = { ":<C-U>Gitsigns select_hunk<CR>", desc = "inside Git hunk" }
        end

        astrocore.set_mappings(maps, { buffer = bufnr })
      end
    end,
  },
}
