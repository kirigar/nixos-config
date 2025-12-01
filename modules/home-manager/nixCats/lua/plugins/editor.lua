require("lz.n").load({
  {
    "guess-indent.nvim",
    event = "BufReadPre",
    after = function()
      require("guess-indent").setup({})
    end,
  },
  {
    "gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    after = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
          local gitsigns = require("gitsigns")

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "]c", bang = true })
            else
              gitsigns.nav_hunk("next")
            end
          end, { desc = "Jump to next git [c]hange" })

          map("n", "[c", function()
            if vim.wo.diff then
              vim.cmd.normal({ "[c", bang = true })
            else
              gitsigns.nav_hunk("prev")
            end
          end, { desc = "Jump to previous git [c]hange" })

          -- Actions
          -- visual mode
          map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "git [s]tage hunk" })
          map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "git [r]eset hunk" })
          -- normal mode
          map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
          map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
          map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
          map("n", "<leader>hu", gitsigns.stage_hunk, { desc = "git [u]ndo stage hunk" })
          map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
          map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
          map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
          map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
          map("n", "<leader>hD", function()
            gitsigns.diffthis("@")
          end, { desc = "git [D]iff against last commit" })
          -- Toggles
          map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
          map("n", "<leader>tD", gitsigns.preview_hunk_inline, { desc = "[T]oggle git show [D]eleted" })
        end,
      })
    end,
  },
  {
    "telescope.nvim",
    event = "VimEnter",
    after = function()
      local actions = require("telescope.actions")

      require("telescope").setup({
        defaults = {
          path_display = { "truncate" },
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous, -- Move up with Ctrl-k
              ["<C-j>"] = actions.move_selection_next, -- Move down with Ctrl-j
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- Send to quickfix
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },
  {
    "trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
    },
    after = function()
      require("trouble").setup({
        focus = true,
      })
    end,
  },
  {
    "todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "[S]earch [T]odos" },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
    },
    after = function()
      require("todo-comments").setup({
        signs = false,
      })
    end,
  },
  {
    "mini.nvim",
    after = function()
      -- Better Around/Inside textobjects
      require("mini.ai").setup({ n_lines = 500 })

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require("mini.surround").setup()

      local files = require("mini.files")
      files.setup()
      vim.keymap.set("n", "<leader>e", function()
        if not files.close() then
          files.open(vim.api.nvim_buf_get_name(0))
        end
      end, { desc = "File [E]xplorer" })

      local icons = require("mini.icons")
      icons.setup()
      icons.mock_nvim_web_devicons()

      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          -- Highlight hex color strings (#rrggbb) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      local indentscope = require("mini.indentscope")
      indentscope.setup({
        symbol = "│",
        -- draw = { animation = indentscope.gen_animation.linear({}) },
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
})
