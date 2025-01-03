return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
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

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
      dashboard.button( "f", "  > Find file", ":cd $HOME/dev | Telescope find_files<CR>"),
      dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
      dashboard.button( "s", "  > Settings" , ":Neotree toggle $HOME/.config/nvim/lua/plugins<CR>"),
      dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
    }

    alpha.setup(dashboard.opts)
    vim.keymap.set("n", "<leader>ad", ":Alpha<CR>", { desc = "Alpha Dashboard" })
  end,
}
