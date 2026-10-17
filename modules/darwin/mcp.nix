{
  config,
  host,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  homeConfig = config.home-manager.users.${host.username};
  rea-agents = inputs.self.packages.${host.system}.rea-agents;

  servers = {
    github = {
      url = "https://api.githubcopilot.com/mcp";
      headers = {
        Authorization = "Bearer ${config.sops.placeholder."github/mcp_token"}";
        X-MCP-Toolsets = "repos,issues,pull_requests,actions";
        X-MCP-Readonly = "true";
      };
    };
    nixos = {
      command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      args = [ ];
    };
    sequential-thinking = {
      command = "${pkgs.mcp-server-sequential-thinking}/bin/mcp-server-sequential-thinking";
      args = [ ];
    };
    context7 = {
      url = "https://mcp.context7.com/mcp";
      headers = {
        Authorization = "Bearer ${config.sops.placeholder."context7/token"}";
      };
    };
    rea = {
      command = "${rea-agents}/bin/rea";
      args = [ "mcp" ];
      # The full tool catalog is several megabytes per request. These
      # profiles advertise smaller schemas; REA still validates complete
      # inputs and outputs on the server.
      env = {
        REA_MCP_INPUT_SCHEMA_PROFILE = "compact";
        REA_MCP_OUTPUT_SCHEMA_PROFILE = "off";
        # GUI-launched agents do not inherit shell session variables, so the
        # native-analysis engine is pointed at explicitly.
        GHIDRA_INSTALL_DIR = "${pkgs.ghidra}/lib/ghidra";
        JAVA_HOME = "${pkgs.jdk21}";
      };
      codex = {
        startup_timeout_sec = 30;
        tool_timeout_sec = 450;
      };
    };
  };

  codexServers = builtins.mapAttrs (
    _: server:
    if server ? url then
      {
        inherit (server) url;
        http_headers = server.headers or { };
      }
    else
      removeAttrs server [ "codex" ] // (server.codex or { })
  ) servers;

  antigravityServers = builtins.mapAttrs (
    _: server:
    if server ? url then
      {
        serverUrl = server.url;
        headers = server.headers or { };
      }
    else
      removeAttrs server [ "codex" ]
  ) servers;

  opencodeServers = builtins.mapAttrs (
    _: server:
    if server ? url then
      {
        type = "remote";
        inherit (server) url;
        headers = server.headers or { };
        disabled = false;
        oauth = false;
      }
    else
      {
        type = "local";
        command = [ server.command ] ++ (server.args or [ ]);
        disabled = false;
      }
      // lib.optionalAttrs (server ? env) { environment = server.env; }
  ) servers;
in
{
  sops = {
    inherit (homeConfig.sops) defaultSopsFile;
    age = {
      keyFile = homeConfig.sops.age.keyFile;
      sshKeyPaths = [ ];
    };
    gnupg.sshKeyPaths = [ ];
    secrets."github/mcp_token" = { };
    secrets."context7/token" = { };
    templates = {
      "opencode.jsonc" = {
        path = "${homeConfig.xdg.configHome}/opencode/opencode.jsonc";
        owner = host.username;
        mode = "0400";
        content = builtins.toJSON {
          "$schema" = "https://opencode.ai/config.json";
          plugins = [ ];
          mcp.servers = opencodeServers;
        };
      };
      "codex-config.toml" = {
        path = "/etc/codex/config.toml";
        owner = host.username;
        mode = "0400";
        file = (pkgs.formats.toml { }).generate "codex-config.toml" { mcp_servers = codexServers; };
      };
      "antigravity-mcp.json" = {
        path = "${host.homeDirectory}/.gemini/config/mcp_config.json";
        owner = host.username;
        mode = "0400";
        content = builtins.toJSON { mcpServers = antigravityServers; };
      };
    };
  };
}
