{ pkgs, ... }:

{
  imports = [ ./mcp.nix ];

  fonts.packages = [ pkgs.nerd-fonts.geist-mono ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "chatgpt"
      "codex"
      "discord"
      "ghostty"
      "google-chrome"
      "helium-browser"
      "mos"
      "macs-fan-control"
      "markdown-preview"
      "obsidian"
      "opencode-desktop"
      "spotify"
      "steam"
      "t3-code"
      "telegram"
      "the-unarchiver"
      "whatsapp"
      "zed"
      "zoom"
    ];
  };
}
