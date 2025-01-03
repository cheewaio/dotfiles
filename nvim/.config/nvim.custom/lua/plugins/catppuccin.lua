return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        highlight_overrides = {
          all = function(colors)
            return {
              NvimTreeNormal = { fg = colors.none },
              CmpBorder = { fg = "#3e4145" },
            }
          end,
          latte = function(latte)
            return {
              Normal = { fg = latte.base },
            }
          end,
          frappe = function(frappe)
            return {
              ["@comment"] = { fg = frappe.surface2, style = { "italic" } },
            }
          end,
          macchiato = function(macchiato)
            return {
              LineNr = { fg = macchiato.overlay1 },
            }
          end,
          mocha = function(mocha)
            return {
              LineNr = { fg = mocha.overlay1 },
              Comment = { fg = mocha.flamingo, style = { "italic" } },
            }
          end,
        },
      })
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  }
}
