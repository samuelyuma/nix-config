{ config, ... }:

{
  programs.nixvim = {
    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>f";
        action.__raw = ''
          function()
            require("conform").format({ async = true })
          end
        '';
        options.desc = "Format buffer";
      }
    ];

    plugins = {
      conform-nvim = {
        enable = true;
        autoInstall.enable = true;
        settings = {
          notify_on_error = false;
          default_format_opts.lsp_format = "fallback";
          formatters_by_ft = {
            lua = [ "stylua" ];
            nix = [ "nixfmt" ];
            python = [ "ruff_format" ];
          };
        };
      };

      luasnip.enable = true;

      blink-cmp = {
        enable = true;
        settings = {
          keymap.preset = "default";
          appearance.nerd_font_variant = "mono";
          completion.documentation = {
            auto_show = false;
            auto_show_delay_ms = 500;
          };
          sources.default = [
            "lsp"
            "path"
            "snippets"
          ];
          snippets.preset = "luasnip";
          fuzzy.implementation = "lua";
          signature.enabled = true;
        };
      };

      lspconfig.enable = true;

      treesitter = {
        enable = true;
        highlight.enable = true;
        indent.enable = true;
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          diff
          go
          html
          javascript
          json
          lua
          luadoc
          markdown
          markdown_inline
          nix
          python
          query
          tsx
          typescript
          vim
          vimdoc
        ];
      };

      treesitter-context = {
        enable = true;
        settings.max_lines = 3;
      };

      ts-autotag.enable = true;
    };

    lsp = {
      servers = {
        "*".config.capabilities.__raw = ''
          (function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            capabilities.general = capabilities.general or {}
            capabilities.general.positionEncodings = { "utf-16" }
            return capabilities
          end)()
        '';

        basedpyright = {
          enable = true;
          config.settings.basedpyright.disableOrganizeImports = true;
        };
        gopls.enable = true;

        lua_ls = {
          enable = true;
          config.settings.Lua = {
            format.enable = false;
            runtime = {
              version = "LuaJIT";
              path = [
                "lua/?.lua"
                "lua/?/init.lua"
              ];
            };
            workspace = {
              checkThirdParty = false;
              library.__raw = "vim.api.nvim_get_runtime_file('', true)";
            };
          };
        };

        nixd.enable = true;
        ruff.enable = true;
        ts_ls.enable = true;
      };

      onAttach = ''
        local map = function(keys, func, desc, mode)
          vim.keymap.set(mode or "n", keys, func, {
            buffer = bufnr,
            desc = "LSP: " .. desc,
          })
        end

        map("grn", vim.lsp.buf.rename, "Rename")
        map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })
        map("grD", vim.lsp.buf.declaration, "Go to declaration")
        map("grr", require("telescope.builtin").lsp_references, "Go to references")
        map("gri", require("telescope.builtin").lsp_implementations, "Go to implementation")
        map("grd", require("telescope.builtin").lsp_definitions, "Go to definition")
        map("gO", require("telescope.builtin").lsp_document_symbols, "Document symbols")
        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
        map("grt", require("telescope.builtin").lsp_type_definitions, "Go to type definition")

        if client.name == "lua_ls" then
          client.server_capabilities.documentFormattingProvider = false
        end

        if client.name == "ruff" then
          client.server_capabilities.hoverProvider = false
        end

        if client:supports_method("textDocument/documentHighlight", bufnr) then
          local highlight_group = vim.api.nvim_create_augroup(
            "kickstart-lsp-highlight-" .. bufnr,
            { clear = true }
          )

          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_group,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = highlight_group,
            buffer = bufnr,
            callback = function(event)
              local another_client_supports_highlight = false
              for _, attached_client in ipairs(vim.lsp.get_clients({ bufnr = event.buf })) do
                if
                  attached_client.id ~= event.data.client_id
                  and attached_client:supports_method(
                    "textDocument/documentHighlight",
                    event.buf
                  )
                then
                  another_client_supports_highlight = true
                  break
                end
              end

              if not another_client_supports_highlight then
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = highlight_group,
                  buffer = event.buf,
                })
              end
            end,
          })
        end

        if client:supports_method("textDocument/inlayHint", bufnr) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            )
          end, "Toggle inlay hints")
        end
      '';
    };
  };
}
