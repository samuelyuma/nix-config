{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  rtk = pkgs.rustPlatform.buildRustPackage {
    pname = "rtk";
    version = "0.48.0";
    src = inputs.rtk;
    cargoLock.lockFile = "${inputs.rtk}/Cargo.lock";
    doCheck = false;
  };
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
    serpl

    # Development utilities
    dotenv-cli
    pipreqs
    tree-sitter

    # Language and development tooling
    air
    bun
    cargo
    dotnet-sdk_10
    go
    golangci-lint
    gopls
    (lib.lowPrio corepack)
    nodejs
    rtk
    typst
    uv
    repomix
    code2prompt

    # Containers and migrations
    colima
    docker
    docker-buildx
    docker-compose
    docker-credential-helpers
    go-migrate

    # macOS utilities
    mactop
    mole-cleaner

    # Python tooling
    ruff
  ];
}
