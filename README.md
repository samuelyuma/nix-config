# nix-config

Declarative Nix configuration for one macOS system.

## Layout

- `flake.nix` and `flake/`: inputs, outputs, and flake helpers.
- `hosts/darwin/` and `modules/darwin/`: host and system configuration.
- `modules/home/`: Home Manager configuration by domain.
- `modules/home/agents/`: OpenCode, personal skills, and RTK integration.
- `pkgs/`: custom OpenCode and RTK packages.
- `.agents/skills/`: skills for maintaining this repository.

## Usage

Nix with `nix-command` and `flakes` is required. `direnv` is optional. This flake uses the existing Determinate Nix installation (`nix.enable = false`).

```console
nix develop
nix fmt -- --ci
statix check .
deadnix .
nix flake check
nix build .#darwinConfigurations.darwin.system
```

Entering the development shell installs Git hooks. Formatting and lint checks run before commits, and the full flake check runs before pushes.

Apply the configuration yourself with `nix run .#activate`. The command handles elevation internally. Reload the shell afterward with `exec zsh -l`. Roll back a problematic generation with `sudo darwin-rebuild --rollback`.

Before using Rust tools on a fresh installation, run `rustup default stable` once to install and select the default toolchain. The workshop runner uses its `cargo` command.

## Updating

### Updating Packages

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

The Playwright and mcp-nixos MCP servers and shell plugins are provided by the
locked nixpkgs input.

The OpenCode CLI is pinned in `pkgs/opencode/default.nix`.
Update its version and archive hash together, then activate; the package
disables OpenCode's self-updater so Nix remains the version owner.

### Removing a Homebrew Cask

Delete the entry from the `casks` list in `modules/darwin/default.nix`,
then activate — with `onActivation.cleanup = "uninstall"`, brew removes
any tracked cask missing from the list. Apps brew does not track (e.g. a
leftover `<AppName>.app` installed by hand) must be deleted once manually:

```console
sudo rm -rf "/Applications/<AppName>.app"
nix run .#activate
```

## Secrets (sops-nix)

GitHub tokens in `modules/home/agents/mcp.nix` (MCP) and `modules/home/vcs`
(git push/pull) are injected from `secrets/secrets.yaml`, which stays
encrypted in git. First-time setup:

```console
age-keygen -o ~/.config/sops/age/keys.txt
```

Put the printed `age1...` public key into `.sops.yaml`, then store the secrets:

```console
sops secrets/secrets.yaml
```

### Generating the Tokens

Create two separate fine-grained PATs at **github.com → Settings →
Developer settings → Personal access tokens → Fine-grained tokens →
Generate new token**. Never reuse one token for both — they have different
scopes and travel to different endpoints:

- `mcp_token` (read-only API use), repository access limited to the repos
  you work in, permissions **Contents: Read**, **Issues: Read**,
  **Metadata: Read**
- `personal_access_token` (push/pull), same repository selection, permissions
  **Contents: Read and write**, **Metadata: Read**

Both expire (90 days recommended). When pushes or MCP calls start failing
with auth errors, regenerate at the same page and continue below. If a
selected repo sits in an org with SAML enforcement, click **Configure SSO
→ Authorize** on the token or org access silently fails.

Replace the placeholders, save, and apply:

```yaml
github:
  mcp_token: github_pat_11...
  personal_access_token: github_pat_11...
```

```console
nix run .#activate
```

Until `github/personal_access_token` exists in `secrets.yaml`, git keeps
using an in-memory cache (this git is built without osxkeychain support);
the sops-rendered `~/.git-credentials` takes over automatically on the
first activation after you add it.

To add another secret later, add it under a new key in
`secrets/secrets.yaml` via `sops secrets/secrets.yaml`, reference it in
nix as `config.sops.placeholder."<section>/<key>"`, and re-run activation.
Rotate any token that ever sat in plaintext config on the provider side.
