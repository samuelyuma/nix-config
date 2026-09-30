{ config, pkgs, ... }:

{
  sops = {
    secrets."github/mcp_token" = { };
    templates."opencode.jsonc" = {
      path = "${config.xdg.configHome}/opencode/opencode.jsonc";
      mode = "0400";
      content = builtins.toJSON {
        "$schema" = "https://opencode.ai/config.json";
        plugins = [ ];
        mcp.servers = {
          playwright = {
            type = "local";
            command = [
              "${pkgs.playwright-mcp}/bin/playwright-mcp"
              "--browser=chromium"
            ];
            disabled = false;
          };
          github = {
            type = "remote";
            url = "https://api.githubcopilot.com/mcp";
            disabled = false;
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
            disabled = false;
          };
          tinyfish = {
            type = "remote";
            url = "https://agent.tinyfish.ai/mcp";
            disabled = false;
          };
        };
      };
    };
  };

}
