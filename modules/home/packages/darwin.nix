{
  lib,
  pkgs,
  inputs,
  host,
  ...
}:
let
  inherit (inputs.self.packages.${host.system}) docker-credential-osxkeychain;

  antigravity-acp = pkgs.antigravity-acp.overrideAttrs (
    finalAttrs: _: {
      version = "1.3.0";
      src = pkgs.fetchurl {
        url = "https://dl.google.com/agy-extensions/releases/macos/agy-acp-server-${finalAttrs.version}-darwin-arm64.zip";
        hash = "sha256-fNlwRfe0/oEXWhB83xb5xRSE48eKUWLK5BUzi7aqW4g=";
      };
    }
  );
in

{
  # MonoCode expects this executable name and launches it without arguments.
  home.file.".local/libexec/monocode/agy_acp_server.par".source =
    pkgs.writeShellScript "agy_acp_server.par" ''
      exec ${lib.getExe pkgs.antigravity-cli} acp "$@"
    '';

  home.packages = with pkgs; [
    # macOS-only language and development tooling
    air
    bun
    dotnet-sdk_10
    inputs.nixpkgs-go.legacyPackages.${host.system}.go_1_27
    golangci-lint
    gopls
    moon

    # AI coding tools
    antigravity-acp
    antigravity-cli

    # macOS containers and utilities
    docker-credential-osxkeychain
    mactop
    mole-cleaner
  ];
}
