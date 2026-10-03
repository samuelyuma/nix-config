{
  config,
  lib,
  pkgs,
  ...
}:
let
  servers = {
    playwright = {
      command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
      args = [ "--browser=chromium" ];
    };
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
    context7.url = "https://mcp.context7.com/mcp";
  };

  codexServers = builtins.mapAttrs (
    _: server:
    if server ? url then
      {
        inherit (server) url;
        http_headers = server.headers or { };
      }
    else
      server
  ) servers;

  antigravityServers = builtins.mapAttrs (
    _: server:
    if server ? url then
      {
        serverUrl = server.url;
        headers = server.headers or { };
      }
    else
      server
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
  ) servers;
in
{
  sops = {
    secrets."github/mcp_token" = { };
    templates = {
      "opencode.jsonc" = {
        path = "${config.xdg.configHome}/opencode/opencode.jsonc";
        mode = "0400";
        content = builtins.toJSON {
          "$schema" = "https://opencode.ai/config.json";
          plugins = [ ];
          mcp.servers = opencodeServers;
        };
      };
      "codex-mcp.toml" = {
        path = "${config.xdg.configHome}/codex/mcp-servers.toml";
        mode = "0400";
        content = builtins.readFile (
          (pkgs.formats.toml { }).generate "codex-mcp.toml" { mcp_servers = codexServers; }
        );
      };
      "antigravity-mcp.json" = {
        path = "${config.home.homeDirectory}/.gemini/config/mcp_config.json";
        mode = "0400";
        content = builtins.toJSON { mcpServers = antigravityServers; };
      };
    };
  };

  home.activation.codexMcpServers = lib.hm.dag.entryAfter [ "writeBoundary" "sops-nix" ] ''
    ${pkgs.python3}/bin/python3 - \
      "${config.home.homeDirectory}/.codex/config.toml" \
      "${config.sops.templates."codex-mcp.toml".path}" <<'PY'
    from pathlib import Path
    import os
    import stat
    import sys
    import tempfile
    from time import monotonic, sleep

    config_path, fragment_path = map(Path, sys.argv[1:])
    begin = "# BEGIN nix-config MCP servers"
    end = "# END nix-config MCP servers"
    original = config_path.read_text() if config_path.exists() else ""
    deadline = monotonic() + 30
    while not fragment_path.is_file() and monotonic() < deadline:
        sleep(0.1)
    if not fragment_path.is_file():
        raise SystemExit(f"SOPS did not render the Codex MCP fragment: {fragment_path}")
    fragment = fragment_path.read_text().strip()
    if (begin in original) != (end in original):
        raise SystemExit("incomplete Nix-managed Codex MCP block")
    if begin in original:
        before, managed = original.split(begin, 1)
        _, after = managed.split(end, 1)
        original = before.rstrip() + "\n" + after.lstrip()
    content = original.rstrip()
    content += ("\n\n" if content else "") + begin + "\n" + fragment + "\n" + end + "\n"
    config_path.parent.mkdir(parents=True, exist_ok=True)
    mode = stat.S_IMODE(config_path.stat().st_mode) if config_path.exists() else 0o600
    with tempfile.NamedTemporaryFile(mode="w", dir=config_path.parent, delete=False) as output:
        output.write(content)
        temporary_path = Path(output.name)
    os.chmod(temporary_path, mode)
    temporary_path.replace(config_path)
    PY
  '';
}
