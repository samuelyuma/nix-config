{ config, pkgs }:
let
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
      // pkgs.lib.optionalAttrs (server ? env) { environment = server.env; }
  ) servers;
in
{
  inherit servers;

  codexConfig = {
    mcp_servers = codexServers;
    agents = {
      default_subagent_model = "gpt-6.1-terra";
      default_subagent_reasoning_effort = "xhigh";
    };
  };

  antigravityConfig = {
    mcpServers = antigravityServers;
  };

  opencodeConfig = {
    "$schema" = "https://opencode.ai/config.json";
    plugins = [ ];
    mcp.servers = opencodeServers;
  };
}
