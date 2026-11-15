{ pkgs, inputs, ... }:

{
  imports = [ ./mcp.nix ];

  environment.systemPackages = [
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.kiri
    inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.monocode
  ];

  fonts.packages = [ pkgs.nerd-fonts.geist-mono ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "uninstall";

    casks = [
      "chatgpt"
      "codex"
      "dbx"
      "discord"
      "dockdoor"
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
      "telegram"
      "the-unarchiver"
      "whatsapp"
      "zed"
      "zoom"
    ];
  };
}
