require("lz.n").load({
  -- {
  --   "catppuccin-nvim",
  --   event = "VimEnter",
  --   after = function()
  --     require("catppuccin").setup({
  --       flavour = "mocha",
  --       term_colors = true,
  --       dim_inactive = {
  --         enabled = true,
  --         shade = "dark",
  --         percentage = 0.15,
  --       },
  --       integrations = {
  --         gitsigns = true,
  --         telescope = true,
  --         treesitter = true,
  --         treesitter_context = true,
  --         markdown = true,
  --         which_key = true,
  --         blink_cmp = {
  --           style = "bordered",
  --         },
  --       },
  --
  --       native_lsp = {
  --         enabled = true,
  --         virtual_text = {
  --           errors = { "italic" },
  --           hints = { "italic" },
  --           warnings = { "italic" },
  --           information = { "italic" },
  --         },
  --         underlines = {
  --           errors = { "underline" },
  --           hints = { "underline" },
  --           warnings = { "underline" },
  --           information = { "underline" },
  --         },
  --         inlay_hints = {
  --           background = true,
  --         },
  --       },
  --     })
  --
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },
  {
    "theme-loader",
    event = "VimEnter",
    load = function()
      local theme_code = nixCats.extra("themeSetup")

      if theme_code and theme_code ~= "" then
        local func, err = loadstring(theme_code)
        if func then
          func()
        else
          print("Error loading theme code: " .. err)
        end
      else
        local colors = nixCats.extra("stylixColors")
        if colors then
          require("lz.n").trigger_load("mini.nvim")
          require("mini.base16").setup({
            palette = colors,
          })
        end
      end
    end,
  },
  {
    "colorful-menu.nvim",
    after = function()
      require("colorful-menu").setup({})
    end,
  },
  {
    "indent-blankline.nvim",
    event = "User FileOpened",
    after = function()
      require("ibl").setup({
        indent = { char = "|" },
        scope = {
          enabled = false,
          show_start = false,
          show_end = false,
        },
      })
    end,
  },
  {
    "render-markdown.nvim",
    before = function()
      require("lz.n").trigger_load({ "nvim-treesitter", "mini.nvim" })
    end,
    after = function()
      require("render-markdown").setup({})
    end,
  },
  {
    "which-key.nvim",
    event = "VimEnter",
    before = function()
      require("lz.n").trigger_load("nvim-web-devicons")
    end,
    after = function()
      require("which-key").setup({
        preset = "modern",
        delay = 200,
        icons = {
          -- set icon mappings to true if you have a Nerd Font
          mappings = true,
          -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
          -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
          keys = {},
        },

        -- Document existing key chains
        spec = {
          { "<leader>s", group = "[S]earch" },
          { "<leader>t", group = "[T]oggle" },
          { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
        },
      })
    end,
  },
})
