return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
    },
    opts = {
      automatic_installation = true,
      capabilities = {
        workspace = {
          fileOperations = {
            didRename = true,
            willRename = true,
          },
        },
      },
      ensure_installed = (function()
        local function has(...)
          return vim.fn.executable(...) == 1
        end
        local ensure_installed = {
          "lua-language-server",
        }
        if has("clang") then
          table.insert(ensure_installed, "clangd")
        end
        if has("elixir") then
          table.insert(ensure_installed, "elixirls")
        end
        if has("go") then
          table.insert(ensure_installed, "gopls")
        end
        if has("helm") then
          table.insert(ensure_installed, "helm_ls")
        end
        if has("npm") then
          table.insert(ensure_installed, "jsonls")
          table.insert(ensure_installed, "vtsls")
        end
        if has("uv") or has("pip") then
          table.insert(ensure_installed, "basedpyright")
        end
        if has("cargo") or has("rustc") then
          table.insert(ensure_installed, "rust_analyzer")
        end
        if has("zig") then
          table.insert(ensure_installed, "zls")
        end
        return ensure_installed
      end)(),
      servers = {
        basedpyright = {},
        clangd = {
          keys = {
            { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
          },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "Makefile",
              "configure.ac",
              "configure.in",
              "config.h.in",
              "meson.build",
              "meson_options.txt",
              "build.ninja"
            )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
              fname
            ) or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = {
            offsetEncoding = { "utf-16" },
          },
          cmd = {
            "clangd",
            "--offset-encoding=utf-16",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },
        gopls = {},
        helm_ls = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
              doc = {
                privateName = { "^_" },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
            },
          },
        },
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
            },
          },
        },
        terraformls = {
          filetypes = {
            "terraform",
            "terraform-vars",
            "tf",
            "tfvars",
          },
        },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          single_file_support = true,
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            javascript = {
              updateImportsOnFileMove = "always",
            },
            typescript = {
              updateImportsOnFileMove = {
                enabled = "always",
              },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = {
                  enabled = true,
                },
                functionLikeReturnTypes = {
                  enabled = true,
                },
                parameterNames = {
                  enabled = "literals",
                },
                parameterTypes = {
                  enabled = true,
                },
                propertyDeclarationTypes = {
                  enabled = true,
                },
                variableTypes = {
                  enabled = false,
                },
              },
            },
          },
        },
        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
              },
              schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              },
            },
          },
        },
      },
      setup = {
        -- clangd = function(_, opts)
        --   local clangd_ext_opts = require("util").opts("clangd_extensions.nvim")
        --   require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        --   return false
        -- end,
        jdtls = function()
          return true
        end,
      },
      handlers = {},
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local handlers = vim.tbl_deep_extend("force", {
        function(server_name)
          local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
          }, servers[server_name] or {})

          if opts.setup[server_name] then
            if opts.setup[server_name](server_name, server_opts) then
              return
            end
          elseif opts.handlers[server_name] then
            if opts.handlers[server_name](server_name) ~= false then
              return
            end
          end
          require("lspconfig")[server_name].setup(server_opts)
        end,
      }, opts.handlers or {})

      require("mason-lspconfig").setup_handlers(handlers)
    end,
  },
}
