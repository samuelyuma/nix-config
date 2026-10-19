{
  lib,
  writeShellApplication,
  nh,
  repo,
}:

writeShellApplication {
  name = "nxc";
  runtimeInputs = [ nh ];
  text = ''
    repo=${lib.escapeShellArg repo}

    usage() {
      cat <<'EOF'
    nxc - manage the nix-config flake

    Usage:
      nxc <command> [arguments]

    Commands:
      apply              Build and activate the configuration
      build              Build the configuration without activating
      check              Run formatting, lint, flake checks, and the system build
      fmt [args...]      Format the repository
      update [input...]  Update flake inputs (all inputs when omitted)
      search <query...>  Search nixpkgs packages
      options <query...> Search NixOS, Home Manager, and nix-darwin options
      try <pkg...>       Open a shell with packages from the pinned nixpkgs
      rollback           Roll back to the previous system generation
      edit [target]      Edit the repository or a named target
      path               Print the repository path
      help               Show this help

    Environment:
      NXC_REPO           Override the repository path
      VISUAL, EDITOR     Editor used by `nxc edit` (default: nvim)
    EOF
    }

    find_repo() {
      local candidate
      if [ -n "''${NXC_REPO:-}" ]; then
        candidate="$NXC_REPO"
        if [ ! -f "$candidate/flake.nix" ] || [ ! -f "$candidate/hosts/darwin/default.nix" ]; then
          printf 'nxc: NXC_REPO does not point to the nix-config flake: %s\n' "$candidate" >&2
          return 1
        fi
        printf '%s\n' "$candidate"
        return 0
      fi

      if [ ! -d "$repo" ] || [ ! -f "$repo/flake.nix" ] || [ ! -f "$repo/hosts/darwin/default.nix" ]; then
        printf 'nxc: repository not found at %s\n' "$repo" >&2
        printf 'nxc: set NXC_REPO to the repository path\n' >&2
        return 1
      fi
      printf '%s\n' "$repo"
    }

    warn_untracked() {
      local untracked
      if command -v git >/dev/null 2>&1 && git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        untracked=$(git -C "$repo" ls-files --others --exclude-standard -- '*.nix')
        if [ -n "$untracked" ]; then
          printf 'nxc: warning: untracked Nix files are invisible to flakes:\n%s\n' "$untracked" >&2
        fi
      fi
    }

    repo="$(find_repo)" || exit 1

    command="''${1:-help}"
    shift || true

    case "$command" in
      apply)
        warn_untracked
        cd "$repo" || exit 1
        exec nix run .#activate
        ;;
      build)
        warn_untracked
        cd "$repo" || exit 1
        exec nh darwin build . -H darwin -o result
        ;;
      check)
        warn_untracked
        cd "$repo" || exit 1
        nix fmt -- --ci
        nix develop -c bash -c 'statix check . && deadnix .'
        nix flake check
        nix build .#darwinConfigurations.darwin.system --no-link
        ;;
      fmt)
        cd "$repo" || exit 1
        if [ "$#" -eq 0 ]; then
          exec nix fmt
        fi
        exec nix fmt -- "$@"
        ;;
      update)
        cd "$repo" || exit 1
        exec nix flake update "$@"
        ;;
      search)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: search requires a query\n' >&2
          usage >&2
          exit 2
        fi
        exec nh search packages "$@"
        ;;
      options)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: options requires a query\n' >&2
          usage >&2
          exit 2
        fi
        exec nh search options "$@"
        ;;
      try)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: try requires at least one package\n' >&2
          usage >&2
          exit 2
        fi
        packages=()
        while [ "$#" -gt 0 ]; do
          case "$1" in
            --)
              shift
              break
              ;;
            -*)
              break
              ;;
            *)
              packages+=("nixpkgs#$1")
              shift
              ;;
          esac
        done
        if [ "''${#packages[@]}" -eq 0 ]; then
          printf 'nxc: try requires at least one package\n' >&2
          usage >&2
          exit 2
        fi
        exec nix shell --inputs-from "$repo" "''${packages[@]}" "$@"
        ;;
      rollback)
        exec sudo darwin-rebuild --rollback
        ;;
      edit)
        target="''${1:-}"
        case "$target" in
          "")
            path="$repo"
            ;;
          flake)
            path="$repo/flake.nix"
            ;;
          hosts)
            path="$repo/flake/hosts.nix"
            ;;
          packages)
            path="$repo/modules/home/packages/default.nix"
            ;;
          shell)
            path="$repo/modules/home/shell/default.nix"
            ;;
          nix)
            path="$repo/modules/home/nix/default.nix"
            ;;
          darwin)
            path="$repo/modules/darwin/default.nix"
            ;;
          readme)
            path="$repo/README.md"
            ;;
          *)
            path="$repo/$target"
            ;;
        esac
        if [ ! -e "$path" ]; then
          printf 'nxc: no such path: %s\n' "$path" >&2
          exit 1
        fi
        exec "''${VISUAL:-''${EDITOR:-nvim}}" "$path"
        ;;
      path)
        printf '%s\n' "$repo"
        ;;
      help | --help | -h)
        usage
        ;;
      *)
        printf 'nxc: unknown command: %s\n' "$command" >&2
        usage >&2
        exit 2
        ;;
    esac
  '';

  meta = {
    description = "Manage the nix-config flake";
    mainProgram = "nxc";
  };
}
