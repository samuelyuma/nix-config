{
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
  home.packages = with pkgs; [
    antigravity-acp

    # macOS-only language and development tooling
    air
    bun
    dotnet-sdk_10
    inputs.nixpkgs-go.legacyPackages.${host.system}.go_1_27
    golangci-lint
    gopls
    moon

    # macOS containers and utilities
    colima
    docker-credential-osxkeychain
    mactop
    mole-cleaner
  ];
}
