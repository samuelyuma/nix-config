{
  pkgs,
  lib,
  inputs,
  host,
  ...
}:
let
  inherit (inputs.self.packages.${host.system})
    opencode
    rtk
    ;
in

{
  home.packages = with pkgs; [
    # Version control
    gh
    git-filter-repo
    git-lfs

    # Shell tools
    shellcheck
    zinit

    # Files and text
    bat
    eza
    fd
    ripgrep
    tree

    # Terminal applications
    lazydocker
    opencode

    # Development utilities
    agent-browser
    dotenv-cli
    pipreqs
    tree-sitter

    # Language and development tooling
    (lib.lowPrio corepack)
    nodejs
    rtk
    typst
    uv
    repomix

    # Containers and migrations
    docker
    docker-buildx
    docker-compose
    go-migrate

    # Python tooling
    ruff
  ];
}
