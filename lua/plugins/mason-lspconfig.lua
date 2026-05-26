return {
  {
    "williamboman/mason-lspconfig.nvim",
    version = "v2.2.0",
    dependencies = {
      {
        "williamboman/mason.nvim",
      },
      {
        "imroc/kubeschema.nvim",
      },
    },
    config = function()
      local function has(...)
        return vim.fn.executable(...) == 1
      end

      local config = {
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
        yamlls = {
          capabilities = {
            workspace = {
              didChangeConfiguration = {
                -- kubeschema.nvim relies on workspace.didChangeConfiguration to implement dynamic schema loading of yamlls.
                -- It is recommended to enable dynamicRegistration (it's also OK not to enable it, but warning logs will be
                -- generated from LspLog, but it will not affect the function of kubeschema.nvim)
                dynamicRegistration = true,
              },
            },
          },
          -- IMPORTANT!!! Set kubeschema's on_attch to yamlls so that kubeschema can dynamically and accurately match the
          -- corresponding schema file based on the yaml file content (APIVersion and Kind).
          on_attach = function(client, bufnr)
            if not client.workspace_did_change_configuration then
              client.workspace_did_change_configuration = function(settings)
                client.notify("workspace/didChangeConfiguration", { settings = settings or nil })
              end
            end
            require("kubeschema").on_attach(client, bufnr)
          end,
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
      }

      if has("clang") then
        config = vim.tbl_deep_extend("force", config, {
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
              ) or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
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
          }
        })
      end

      if has("elixir") then
        config = vim.tbl_deep_extend("force", config, {
          elixirls = {},
        })
      end

      if has("go") then
        config = vim.tbl_deep_extend("force", config, {
          gopls = {},
        })
      end

      if has("helm") then
        config = vim.tbl_deep_extend("force", config, {
          helm_ls = {},
        })
      end

      if has("npm") then
        config = vim.tbl_deep_extend("force", config, {
          jsonls = {},
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
        })
      end

      if has("odin") then
        config = vim.tbl_deep_extend("force", config, {
          ols = {}
        })
      end

      if has("uv") or has("pip") then
        config = vim.tbl_deep_extend("force", config, {
          basedpyright = {
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "basic",
                  -- diagnosticSeverityOverrides = {
                  --   reportAny = false,
                  --   reportUnusedCallResult = false,
                  --   reportMissingTypeArgument = false,
                  --   reportMissingParameterType = false,
                  --   reportUnknownArgumentType = false,
                  --   reportUnknownLambdaType = false,
                  --   reportUnknownMemberType = false,
                  --   reportUnknownParameterType = false,
                  --   reportUnknownVariableType = false
                  -- },
                },
              },
            },
          }
        })
      end

      if has("cargo") or has("rustc") then
        config = vim.tbl_deep_extend("force", config, {
          rust_analyzer = {
            settings = {
              ['rust-analyzer'] = {
              },
            },
          }
        })
      end

      if has("terraform") or has("tofu") then
        config = vim.tbl_deep_extend("force", config, {
          terraformls = {
            filetypes = {
              "terraform",
              "terraform-vars",
              "tf",
              "tfvars",
            },
          }
        })
      end

      if has("zig") then
        config = vim.tbl_deep_extend("force", config, {
          zls = {}
        })
      end

      require("mason-lspconfig").setup({
        ensure_installed = vim.tbl_keys(config),
        automatic_installation = true,
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
      })

      for name, server in pairs(config) do
        vim.lsp.config(name, server)
        vim.lsp.enable(name)
      end
    end,
  },
}
