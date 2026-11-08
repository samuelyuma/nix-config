{
  lib,
  writeShellApplication,
  nh,
  homeManager ? null,
  hostName,
  isLinux ? false,
  repo,
}:

writeShellApplication {
  name = "nxc";
  runtimeInputs = [ nh ] ++ lib.optional isLinux homeManager;
  text = ''
    repo=${lib.escapeShellArg repo}
    host_name=${lib.escapeShellArg hostName}
    is_linux=${if isLinux then "1" else "0"}

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
      local candidate expected_host
      expected_host="hosts/$host_name/default.nix"

      if [ -n "''${NXC_REPO:-}" ]; then
        candidate="$NXC_REPO"
        if [ ! -f "$candidate/flake.nix" ] || [ ! -f "$candidate/$expected_host" ]; then
          printf 'nxc: NXC_REPO does not point to the nix-config flake: %s\n' "$candidate" >&2
          return 1
        fi
        printf '%s\n' "$candidate"
        return 0
      fi

      if [ ! -d "$repo" ] || [ ! -f "$repo/flake.nix" ] || [ ! -f "$repo/$expected_host" ]; then
        printf 'nxc: repository not found at %s\n' "$repo" >&2
        printf 'nxc: set NXC_REPO to the repository path\n' >&2
        return 1
      fi
      printf '%s\n' "$repo"
    }

    warn_untracked() {
      local untracked
      if command -v git >/dev/null 2>&1 && git -C "$repo" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        untracked=$(git -C "$repo" status --porcelain 2>/dev/null | grep '^??' || true)
        if [ -n "$untracked" ]; then
          printf 'warning: untracked files in %s will not be visible to Nix flakes:\n%s\n' "$repo" "$untracked" >&2
          printf 'hint: run git add <file> to stage them\n' >&2
        fi
      fi
    }

    resolved_repo=$(find_repo) || exit 1
    repo="$resolved_repo"

    command="''${1:-help}"
    shift || true

    case "$command" in
      apply)
        warn_untracked
        cd "$repo" || exit 1
        if [ "$is_linux" -eq 1 ]; then
          exec nh home switch "$repo" -c "$host_name"
        fi
        exec nix run .#activate
        ;;
      build)
        warn_untracked
        cd "$repo" || exit 1
        if [ "$is_linux" -eq 1 ]; then
          exec nh home build "$repo" -c "$host_name" -o result
        fi
        exec nh darwin build . -H darwin -o result
        ;;
      check)
        warn_untracked
        cd "$repo" || exit 1
        nix fmt -- --ci
        nix develop -c bash -c 'statix check . && deadnix .'
        nix flake check
        if [ "$is_linux" -eq 1 ]; then
          nix build ".#homeConfigurations.''${host_name}.activationPackage" --no-link
        else
          nix build .#darwinConfigurations.darwin.system --no-link
        fi
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
        if [ "$#" -eq 0 ]; then
          exec nix flake update
        fi
        exec nix flake update "$@"
        ;;
      search)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: search requires at least one query term\n' >&2
          exit 1
        fi
        exec nh search "$@"
        ;;
      options)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: options requires at least one query term\n' >&2
          exit 1
        fi
        cd "$repo" || exit 1
        exec nix run "nixpkgs#manix" -- "$@"
        ;;
      try)
        if [ "$#" -eq 0 ]; then
          printf 'nxc: try requires at least one package name\n' >&2
          exit 1
        fi
        packages=()
        command_args=()
        while [ "$#" -gt 0 ]; do
          case "$1" in
            --command)
              shift
              command_args=("$@")
              break
              ;;
            *)
              packages+=("nixpkgs#$1")
              shift
              ;;
          esac
        done
        cd "$repo" || exit 1
        if [ "''${#command_args[@]}" -gt 0 ]; then
          exec nix shell "''${packages[@]}" --command "''${command_args[@]}"
        fi
        exec nix shell "''${packages[@]}"
        ;;
      rollback)
        cd "$repo" || exit 1
        if [ "$is_linux" -eq 1 ]; then
          exec home-manager generations
        fi
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
          packages-common)
            path="$repo/modules/home/packages/common.nix"
            ;;
          packages-darwin)
            path="$repo/modules/home/packages/darwin.nix"
            ;;
          packages-linux)
            path="$repo/modules/home/packages/linux.nix"
            ;;
          shell)
            path="$repo/modules/home/shell/default.nix"
            ;;
          nix)
            path="$repo/modules/home/nix/default.nix"
            ;;
          mcp)
            path="$repo/modules/shared/mcp-servers.nix"
            ;;
          darwin)
            path="$repo/modules/darwin/default.nix"
            ;;
          linux)
            path="$repo/hosts/linux/default.nix"
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
}
