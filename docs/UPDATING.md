# Updating

## Updating Packages

Nix-managed tools (declared in `modules/home/packages`) update by bumping
the `nixpkgs` lock entry, never via the tool's own updater (e.g. `bun
upgrade` cannot work — the Nix store is read-only). Replace `<package>`
with any tool name to verify it:

```console
nix flake update nixpkgs
nix run .#activate
exec zsh -l
<package> --version
```

OpenCode plugins and `basic-memory` are also pinned, but they are not sourced
from nixpkgs. Update their explicit versions in `modules/home/agents/opencode`, run
the checks above, and activate. The Playwright MCP and shell plugins are
provided by the locked nixpkgs input.

The OpenCode CLI is pinned in `pkgs/opencode/default.nix`.
Update its version and archive hash together, then activate; the package
disables OpenCode's self-updater so Nix remains the version owner.

## Removing a Homebrew Cask

Delete the entry from the `casks` list in `modules/darwin/default.nix`,
then activate — with `onActivation.cleanup = "uninstall"`, brew removes
any tracked cask missing from the list. Apps brew does not track (e.g. a
leftover `<AppName>.app` installed by hand) must be deleted once manually:

```console
sudo rm -rf "/Applications/<AppName>.app"
nix run .#activate
```
