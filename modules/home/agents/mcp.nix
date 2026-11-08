{
  config,
  pkgs,
  ...
}:
let
  homeDirectory = config.home.homeDirectory;
  mcp = import ../../shared/mcp-servers.nix { inherit config pkgs; };
in
{
  sops = {
    secrets."github/mcp_token" = { };
    secrets."context7/token" = { };

    templates = {
      "opencode.jsonc" = {
        path = "${config.xdg.configHome}/opencode/opencode.jsonc";
        mode = "0400";
        content = builtins.toJSON mcp.opencodeConfig;
      };
      "codex-config.toml" = {
        path = "${homeDirectory}/.codex/config.toml";
        mode = "0400";
        file = (pkgs.formats.toml { }).generate "codex-config.toml" mcp.codexConfig;
      };
      "antigravity-mcp.json" = {
        path = "${homeDirectory}/.gemini/config/mcp_config.json";
        mode = "0400";
        content = builtins.toJSON mcp.antigravityConfig;
      };
    };
  };
}
