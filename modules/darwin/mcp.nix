{
  config,
  host,
  pkgs,
  ...
}:
let
  homeConfig = config.home-manager.users.${host.username};
  mcp = import ../shared/mcp-servers.nix { inherit config pkgs; };
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
        content = builtins.toJSON mcp.opencodeConfig;
      };
      "codex-config.toml" = {
        path = "/etc/codex/config.toml";
        owner = host.username;
        mode = "0400";
        file = (pkgs.formats.toml { }).generate "codex-config.toml" mcp.codexConfig;
      };
      "antigravity-mcp.json" = {
        path = "${host.homeDirectory}/.gemini/config/mcp_config.json";
        owner = host.username;
        mode = "0400";
        content = builtins.toJSON mcp.antigravityConfig;
      };
    };
  };
}
