{ pkgs, ... }:

{
  imports = [ ./mcp.nix ];

  fonts.packages = [ pkgs.nerd-fonts.geist-mono ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "arc"
      "chatgpt"
      "codex"
      "discord"
      "ghostty"
      "google-chrome"
      "helium-browser"
      "linearmouse"
      "macs-fan-control"
      "markdown-preview"
      "microsoft-word"
      "obsidian"
      "opencode-desktop"
      "spotify"
      "steam"
      "t3-code"
      "tailscale-app"
      "telegram"
      "the-unarchiver"
      "whatsapp"
      "zed"
      "zoom"
    ];
  };
}
