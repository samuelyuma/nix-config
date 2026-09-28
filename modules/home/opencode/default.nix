{
  config,
  lib,
  pkgs,
  ...
}:

let
  basicMemoryVersion = "0.23.2";

  zenFreeModels = [
    "opencode/muse-spark-1.3-contributor-free"
    { model = "opencode/muse-spark-1.2-contributor-free"; }
    { model = "opencode/nemotron-3.5-lightning-free"; }
    { model = "opencode/nemotron-3-ultra-free"; }
    { model = "opencode/mimo-v2.5-free"; }
    { model = "opencode/ling-3.0-flash-fin-free"; }
  ];

  omoAgentNames = [
    "sisyphus"
    "hephaestus"
    "oracle"
    "librarian"
    "explore"
    "multimodal-looker"
    "prometheus"
    "metis"
    "momus"
    "atlas"
    "sisyphus-junior"
    "code-reviewer"
  ];

  omoCategoryNames = [
    "visual-engineering"
    "ultrabrain"
    "deep"
    "artistry"
    "quick"
    "unspecified-low"
    "unspecified-high"
    "writing"
  ];

  primaryModel = builtins.head zenFreeModels;
  omoAgents = builtins.listToAttrs (
    map (name: {
      inherit name;
      value.model = primaryModel;
    }) omoAgentNames
  );
  omoCategories = builtins.listToAttrs (
    map (name: {
      inherit name;
      value.models = zenFreeModels;
    }) omoCategoryNames
  );
in
{
  home.file.".omo/omo.jsonc" = {
    force = true;
    text = builtins.toJSON {
      "$schema" =
        "https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/dev/assets/omo.schema.json";
      "[opencode]" = {
        agents = omoAgents;
        categories = omoCategories;
        codegraph = { };
      };
      "[codex]".codegraph = { };
      codegraph = { };
      _migrations = [
        "2026-07-codex-config-jsonc"
        "2026-08-reasoning-unification"
      ];
    };
  };

  sops = {
    secrets."github/mcp_token" = { };
    templates."opencode.jsonc" = {
      path = "${config.xdg.configHome}/opencode/opencode.jsonc";
      mode = "0400";
      content = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugin = [
          "oh-my-openagent@4.19.4"
          "@dietrichgebert/ponytail@4.10.0"
        ];
        mcp = {
          playwright = {
            type = "local";
            command = [
              "${pkgs.playwright-mcp}/bin/playwright-mcp"
              "--browser=chromium"
            ];
            enabled = true;
          };
          github = {
            type = "remote";
            url = "https://api.githubcopilot.com/mcp";
            enabled = true;
            oauth = false;
            headers = {
              Authorization = "Bearer ${config.sops.placeholder."github/mcp_token"}";
              X-MCP-Toolsets = "repos,issues";
              X-MCP-Readonly = "true";
            };
          };
          basic-memory = {
            type = "local";
            command = [
              "${config.home.homeDirectory}/.local/bin/basic-memory"
              "mcp"
            ];
            enabled = true;
          };
          tinyfish = {
            type = "remote";
            url = "https://agent.tinyfish.ai/mcp";
            enabled = true;
          };
        };
      };
    };
  };

  home.activation = {
    installBasicMemory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      export PATH="${config.home.homeDirectory}/.local/bin:$PATH"
      basic_memory="${config.home.homeDirectory}/.local/bin/basic-memory"
      installed_version=""
      if [ -x "$basic_memory" ]; then
        installed_version="$($basic_memory --version 2>/dev/null | ${pkgs.gawk}/bin/awk '{ print $NF }' || true)"
      fi
      if [ "$installed_version" != "${basicMemoryVersion}" ]; then
        $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --force "basic-memory==${basicMemoryVersion}" \
          || echo "warning: basic-memory install failed (offline?) - rerun activation later"
      fi
    '';
  };
}
