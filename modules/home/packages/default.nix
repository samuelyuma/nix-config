{
  pkgs,
  lib,
  inputs,
  host,
  ...
}:
let
  antigravity-acp = pkgs.antigravity-acp.overrideAttrs (
    finalAttrs: _: {
      version = "1.3.0";
      src = pkgs.fetchurl {
        url = "https://dl.google.com/agy-extensions/releases/macos/agy-acp-server-${finalAttrs.version}-darwin-arm64.zip";
        hash = "sha256-fNlwRfe0/oEXWhB83xb5xRSE48eKUWLK5BUzi7aqW4g=";
      };
    }
  );

  inherit (inputs.self.packages.${host.system})
    docker-credential-osxkeychain
    opencode
    rtk
    workshop-runner
    ;
in

{
  home.packages = with pkgs; [
    # Version control
    gh
    git-filter-repo
    git-lfs

    # Shell tools
    gum

    # Files and text
    bat
    eza
    fd
    ripgrep
    tree

    # Terminal applications
    antigravity-acp
    jnv
    lazydocker
    opencode
    serpl

    # Development utilities
    agent-browser
    dotenv-cli
    moon
    pipreqs
    tree-sitter

    # Language and development tooling
    air
    bun
    dotnet-sdk_10
    go
    golangci-lint
    gopls
    (lib.lowPrio corepack)
    nodejs
    rtk
    rustup
    typst
    uv
    repomix
    code2prompt
    workshop-runner

    # Containers and migrations
    colima
    docker
    docker-buildx
    docker-compose
    docker-credential-osxkeychain
    go-migrate

    # macOS utilities
    mactop
    mole-cleaner

    # Python tooling
    ruff
  ];
}
