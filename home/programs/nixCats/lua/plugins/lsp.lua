require("lz.n").load({
  {
    {
      -- lazydev makes your lsp way better in your config without needing extra lsp configuration.
      "lazydev.nvim",
      cmd = "LazyDev",
      ft = "lua",
      after = function()
        require("lazydev").setup({
          library = {
            { words = { "nixCats" }, path = (nixCats.nixCatsPath or "") .. "/lua" },
          },
        })
      end,
    },
    {
      "nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      after = function()
        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
          callback = function(args)
            -- Get the client and buffer from the event arguments [cite: 119]
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf

            local map = function(keys, func, desc, mode)
              mode = mode or "n"
              vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
            end

            -- Mappings (Standard LSP functions from lsp-defaults) [cite: 20-23]
            map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
            map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
            map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

            -- Telescope Mappings
            map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
            map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
            map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
            map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

            -- Highlight references (Document Highlight)
            if client and client:supports_method("textDocument/documentHighlight", bufnr) then
              local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
              vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

              vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = bufnr,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

              vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
                callback = function(event)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event.buf })
                end,
              })
            end

            -- Inlay Hints
            if client and client:supports_method("textDocument/inlayHint", bufnr) then
              map("<leader>th", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
              end, "[T]oggle Inlay [H]ints")
            end
          end,
        })

        -- 1. Setup Diagnostics (Visuals)
        vim.diagnostic.config({
          severity_sort = true,
          float = { border = "rounded", source = "if_many" },
          underline = { severity = vim.diagnostic.severity.ERROR },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = " ",
              [vim.diagnostic.severity.WARN] = " ",
              [vim.diagnostic.severity.INFO] = " ",
              [vim.diagnostic.severity.HINT] = "󰠠 ",
            },
          },
          virtual_text = {
            source = "if_many",
            spacing = 4,
            prefix = "●",
            format = function(diagnostic)
              local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
              }
              return diagnostic_message[diagnostic.severity]
            end,
          },
        })

        vim.lsp.config("lua_ls", {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              signatureHelp = { enabled = true },
              diagnostics = { globals = { "nixCats", "vim" } },
              telemetry = { enabled = false },
              completion = { callSnippet = "Replace" },
            },
          },
        })
        vim.lsp.enable("lua_ls")

        -- Nix
        vim.lsp.config("nixd", {
          settings = {
            nixd = {
              nixpkgs = { expr = nixCats.extra("nixdExtras.nixpkgs") },
              options = {
                nixos = { expr = nixCats.extra("nixdExtras.nixos_options") },
                ["home-manager"] = { expr = nixCats.extra("nixdExtras.home_manager_options") },
              },
              formatting = { command = { "nixfmt" } },
            },
          },
        })
        vim.lsp.enable("nixd")

        -- Dafny
        vim.lsp.enable("dafny")

        -- TypeScript/JS
        vim.lsp.enable("ts_ls")

        -- Rust
        vim.lsp.enable("rust_analyzer")

        -- Python
        vim.lsp.config("basedpyright", {
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "standard",
                inlayHints = {
                  variableTypes = true,
                  callArgumentNames = true,
                  functionReturnTypes = true,
                },
              },
            },
          },
        })
        vim.lsp.enable("basedpyright")
      end,
    },
  },
})
