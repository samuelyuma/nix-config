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

## Agent Skills

Skills are selected in [skills.nix](modules/home/agents/skills.nix) and installed
into `~/.codex/skills` and `~/.config/opencode/skills` during activation.

Personal skills live in `modules/home/agents/skills/`:

- [writing](modules/home/agents/skills/writing/SKILL.md): clear prose for chat,
  documents, PR descriptions, commit messages, and code comments.
- [documentation](modules/home/agents/skills/documentation/SKILL.md): READMEs,
  guides, release notes, changelogs, reports, proposals, and agent instructions,
  with questions for missing information.
- [research](modules/home/agents/skills/research/SKILL.md): investigate questions,
  verify claims, and compare options. Answers in chat by default; writes a file
  when requested.
- [plan](modules/home/agents/skills/plan/SKILL.md): create, review, and update
  implementation plans, with focused bug diagnosis and verification steps.

Other skill sources and selections are listed in `skills.nix`. Repository
maintenance skills live in `.agents/skills/`. Edit the source files, then
activate to update the installed skills.

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

The agent-browser CLI, MCP servers, and shell plugins are provided by the
locked nixpkgs input. The agent-browser skill comes from its pinned upstream
repository.

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

GitHub tokens in `modules/darwin/mcp.nix` (MCP) and `modules/home/vcs`
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

Set `githubGitCredentials = false` in `flake/hosts.nix` until you configure
`github/personal_access_token`. Git then uses an in-memory cache (this git
is built without osxkeychain support). Set the flag to `true` and activate
to use the sops-rendered `~/.git-credentials`.

To add another secret later, add it under a new key in
`secrets/secrets.yaml` via `sops secrets/secrets.yaml`, reference it in
nix as `config.sops.placeholder."<section>/<key>"`, and re-run activation.
Rotate any token that ever sat in plaintext config on the provider side.

MCP settings for Codex, OpenCode, and Antigravity are declared together in
`modules/darwin/mcp.nix`. sops-nix renders their configuration files during
system activation, with ownership and permissions restricted to the configured
user. Codex reads MCP defaults from `/etc/codex/config.toml`, keeping
`~/.codex/config.toml` available for its own settings. See the
[Codex configuration layers](https://learn.chatgpt.com/docs/config-file/config-basic)
and [sops-nix templates](https://github.com/Mic92/sops-nix#templates).

When migrating from the previous MCP merger, remove the block between
`# BEGIN nix-config MCP servers` and `# END nix-config MCP servers` from
`~/.codex/config.toml` once. Also remove any separate definitions for the same
managed server names (`github`, `nixos`, `sequential-thinking`, and `context7`),
and obsolete `playwright` entries. User-level
entries override system defaults. Other Codex settings can remain in that file.
