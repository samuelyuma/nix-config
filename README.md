# nix-config

Declarative nix-darwin and Home Manager configuration for one macOS machine
(`aarch64-darwin`, user `yumx`).

## Table of Contents

- [Overview](#overview)
- [Layout](#layout)
  - [Detailed Structure](docs/STRUCTURE.md)
- [Quick Start](#quick-start)
- [Checks](#checks)
- [Everyday Commands](#everyday-commands)
- [Daily Workflow](#daily-workflow)
- [Agent Skills](#agent-skills)
- [Updating](#updating)
  - [Updating Packages](#updating-packages)
  - [Removing a Homebrew Cask](#removing-a-homebrew-cask)
- [Secrets (sops-nix)](#secrets-sops-nix)
  - [Generating the Tokens](#generating-the-tokens)
  - [MCP Configuration](#mcp-configuration)

## Overview

- Nix-darwin manages the system; Home Manager manages user packages and dotfiles.
- The flake uses the existing Determinate Nix installation (`nix.enable = false`).
- Nix with `nix-command` and `flakes` is required; `direnv` is optional.
- `nxc` is the repository CLI. Home Manager installs it, so it is available
  from any directory after the first activation.

## Layout

```text
nix-config/
├── flake.nix            # flake inputs and outputs
├── flake.lock           # locked input revisions
├── flake/               # activation, dev shell, Git hooks, host wiring
├── hosts/               # machine entry points
├── modules/
│   ├── darwin/          # system configuration and MCP rendering
│   └── home/
│       ├── agents/      # OpenCode, skills, and RTK
│       ├── editor/      # Neovim and language tooling
│       ├── nix/         # nxc installation
│       ├── packages/    # permanent user packages
│       ├── security/    # sops and age setup
│       ├── shell/       # zsh, starship, direnv, and CLI tools
│       ├── terminal/    # Ghostty configuration
│       └── vcs/         # Git and credentials
├── pkgs/                # custom packages (nxc, OpenCode, RTK, ...)
├── secrets/             # sops-encrypted secrets
├── docs/                # detailed project documentation
├── .agents/             # repository maintenance skills
├── AGENTS.md            # agent instructions
└── README.md            # project overview and commands
```

See [docs/STRUCTURE.md](docs/STRUCTURE.md) for the full tree and module map.

## Quick Start

```console
nix develop
nix run .#activate
exec zsh -l
nxc path
nxc help
```

- `nix run .#activate` is only needed before `nxc` is installed. After that,
  use `nxc apply`.
- `nix develop` installs Git hooks: formatting and lint checks run before
  commits; the full flake check runs before pushes.

## Checks

Run the full suite from the repository root:

```console
nix fmt -- --ci
nix develop -c bash -c 'statix check . && deadnix .'
nix flake check
nix build .#darwinConfigurations.darwin.system
```

After `nxc` is installed, `nxc check` runs the same checks from any directory.

## Everyday Commands

`nxc` manages this repository and does not replace `nh` or any existing shell
alias.

| Command | Description |
| --- | --- |
| `nxc apply` | Activate the configuration. |
| `nxc build` | Build without activating; writes `result`. |
| `nxc check` | Run formatting, lint, flake checks, and the system build. |
| `nxc fmt` | Format the repository. |
| `nxc update` | Update all flake inputs. |
| `nxc search ripgrep` | Search nixpkgs packages. |
| `nxc options fonts` | Search NixOS, Home Manager, and nix-darwin options. |
| `nxc try ripgrep` | Open a temporary shell with packages from pinned nixpkgs. |
| `nxc rollback` | Roll back the previous system generation. |
| `nxc edit packages` | Edit `modules/home/packages/default.nix`. |
| `nxc path` | Print the repository path. |
| `nxc help` | Show all commands. |

Details:

- `nxc apply` uses the same activation path as `nix run .#activate`.
- `nxc build` uses `nh` internally and writes `result`; `nh` is not installed
  separately.
- `nxc check` runs the checks above. `nxc fmt --ci` checks formatting, and
  `nxc update nixpkgs` updates one input; omit the name to update all inputs.
- `nxc try ripgrep --command rg --version` runs one command instead of opening
  a shell.
- `nxc edit` accepts `flake`, `hosts`, `packages`, `shell`, `nix`, `darwin`, or
  `readme`; other values are paths relative to the repository. With no target,
  it opens the repository root. The editor comes from `VISUAL`, then `EDITOR`,
  then `nvim`.
- `nxc rollback` uses `sudo`. Set `NXC_REPO` to override the repository path.
- Add permanent packages with `nxc edit packages`; use `nxc try` for temporary
  tools.

## Daily Workflow

After the first activation, the normal loop is:

```mermaid
flowchart TD
    Edit["Edit config"] --> Fmt["nxc fmt"]
    Fmt --> Check["nxc check"]
    Check -->|pass| Build["nxc build"]
    Check -->|fail| Edit
    Build --> Apply["nxc apply"]
    Apply --> Reload["exec zsh -l"]
    Apply -->|bad generation| Rollback["nxc rollback"]
```

## Agent Skills

- Skills are selected in [skills.nix](modules/home/agents/skills.nix) and
  installed into `~/.codex/skills` and `~/.config/opencode/skills` during
  activation.
- Personal skills live in `modules/home/agents/skills/`:
  - [writing](modules/home/agents/skills/writing/SKILL.md): clear prose for
    chat, documents, PR descriptions, commit messages, and code comments.
  - [documentation](modules/home/agents/skills/documentation/SKILL.md): READMEs,
    guides, release notes, changelogs, reports, proposals, and agent
    instructions, with questions for missing information.
  - [research](modules/home/agents/skills/research/SKILL.md): investigate
    questions, verify claims, and compare options. Answers in chat by default;
    writes a file when requested.
  - [plan](modules/home/agents/skills/plan/SKILL.md): create, review, and update
    implementation plans, with focused bug diagnosis and verification steps.
- Other skill sources and selections are listed in `skills.nix`.
- Repository maintenance skills live in `.agents/skills/`.
- Edit the source files, then activate to update installed skills.

## Updating

### Updating Packages

- Nix-managed tools are declared in `modules/home/packages`.
- Update them by bumping the `nixpkgs` lock entry, never with the tool's own
  updater. For example, `bun upgrade` cannot work because the Nix store is
  read-only.
- Replace `<package>` with the tool to verify:

  ```console
  nxc update nixpkgs
  nxc apply
  exec zsh -l
  <package> --version
  ```

- If `nxc` is not installed yet, use `nix flake update nixpkgs` and
  `nix run .#activate` instead.
- The agent-browser CLI, MCP servers, and shell plugins come from the locked
  nixpkgs input. The agent-browser skill comes from its pinned upstream
  repository.
- The OpenCode CLI is pinned in `pkgs/opencode/default.nix`. Update its version
  and archive hash together, then activate. Its self-updater is disabled so Nix
  remains the version owner.

### Removing a Homebrew Cask

1. Delete the entry from the `casks` list in `modules/darwin/default.nix`.
2. Activate:

   ```console
   nxc apply
   ```

   With `onActivation.cleanup = "uninstall"`, brew removes any tracked cask
   missing from the list.

3. Delete leftovers that brew does not track, such as an app installed by hand:

   ```console
   sudo rm -rf "/Applications/<AppName>.app"
   ```

## Secrets (sops-nix)

- GitHub tokens are injected from `secrets/secrets.yaml`, which stays encrypted
  in git.
- MCP tokens are configured in `modules/darwin/mcp.nix`; git push/pull tokens
  are configured in `modules/home/vcs`.
- Never open, decrypt, or edit `secrets/secrets.yaml` directly. Use `sops`.

First-time setup:

1. Run `age-keygen -o ~/.config/sops/age/keys.txt`.
2. Add the printed `age1...` public key to `.sops.yaml`.
3. Run `sops secrets/secrets.yaml`.

### Generating the Tokens

- Create two separate fine-grained PATs at **github.com → Settings →
  Developer settings → Personal access tokens → Fine-grained tokens →
  Generate new token**.
- Never reuse one token for both; they have different scopes and endpoints.

| Token | Access | Permissions |
| --- | --- | --- |
| `mcp_token` | MCP, read-only API use | Contents: Read, Issues: Read, Metadata: Read |
| `personal_access_token` | Git push/pull | Contents: Read and write, Metadata: Read |

- Limit repository access to the repositories you work in.
- Both tokens expire; 90 days is recommended. Regenerate them when pushes or
  MCP calls start failing with auth errors.
- If a selected repository is in an org with SAML enforcement, click
  **Configure SSO → Authorize** on the token, or org access fails silently.
- Replace the placeholders in `secrets/secrets.yaml`:

  ```yaml
  github:
    mcp_token: github_pat_11...
    personal_access_token: github_pat_11...
  ```

- Apply with `nxc apply` (or `nix run .#activate` before `nxc` is installed).
- Set `githubGitCredentials = false` in `flake/hosts.nix` until
  `github/personal_access_token` is configured. Git then uses an in-memory
  cache because this git is built without osxkeychain support. Set the flag to
  `true` and activate to use the sops-rendered `~/.git-credentials`.
- To add another secret:
  1. Add a new key with `sops secrets/secrets.yaml`.
  2. Reference it as `config.sops.placeholder."<section>/<key>"`.
  3. Re-run activation.
- Rotate any token that ever appeared in plaintext configuration.

### MCP Configuration

- MCP settings for Codex, OpenCode, and Antigravity are declared together in
  `modules/darwin/mcp.nix`.
- sops-nix renders their configuration files during system activation with
  ownership and permissions restricted to the configured user.
- Codex reads MCP defaults from `/etc/codex/config.toml`; `~/.codex/config.toml`
  remains available for user settings.
- See the [Codex configuration layers](https://learn.chatgpt.com/docs/config-file/config-basic)
  and [sops-nix templates](https://github.com/Mic92/sops-nix#templates).

When migrating from the previous MCP merger:

- Remove the block between `# BEGIN nix-config MCP servers` and
  `# END nix-config MCP servers` from `~/.codex/config.toml` once.
- Remove any separate definitions for the same managed server names (`github`,
  `nixos`, `sequential-thinking`, and `context7`).
- Remove obsolete `playwright` entries.
- User-level entries override system defaults; other Codex settings can remain
  in that file.
