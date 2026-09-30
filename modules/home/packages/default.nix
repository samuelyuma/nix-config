{
  pkgs,
  lib,
  inputs,
  host,
  ...
}:
let
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
    jnv
    lazydocker
    opencode
    serpl

    # Development utilities
    dotenv-cli
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
