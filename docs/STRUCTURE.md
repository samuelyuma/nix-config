# Repository Structure

This page is the detailed map of the repository. For setup, commands, and
workflows, see the [README](../README.md).

## Full Tree

```text
nix-config/
├── flake.nix
├── flake.lock
├── flake/
│   ├── activate.nix
│   ├── devshell.nix
│   ├── git-hooks.nix
│   └── hosts.nix
├── hosts/
│   └── darwin/
│       └── default.nix
├── modules/
│   ├── darwin/
│   │   ├── default.nix
│   │   └── mcp.nix
│   └── home/
│       ├── default.nix
│       ├── agents/
│       │   ├── default.nix
│       │   ├── global-agents.md
│       │   ├── opencode/
│       │   │   └── default.nix
│       │   ├── rtk.nix
│       │   ├── rtk-codex.md
│       │   ├── skills.nix
│       │   └── skills/
│       │       ├── agent-instructions/
│       │       ├── documentation/
│       │       ├── plan/
│       │       ├── research/
│       │       └── writing/
│       ├── editor/
│       │   ├── default.nix
│       │   ├── languages.nix
│       │   └── testing.nix
│       ├── nix/
│       │   └── default.nix
│       ├── packages/
│       │   └── default.nix
│       ├── security/
│       │   └── default.nix
│       ├── shell/
│       │   ├── default.nix
│       │   └── starship.toml
│       ├── terminal/
│       │   ├── default.nix
│       │   └── ghostty.conf
│       └── vcs/
│           └── git.nix
├── pkgs/
│   ├── nxc/
│   │   └── default.nix
│   ├── opencode/
│   │   └── default.nix
│   ├── docker-credential-osxkeychain.nix
│   └── rtk.nix
├── secrets/
│   └── secrets.yaml
├── docs/
│   └── STRUCTURE.md
├── .agents/
│   └── skills/
│       ├── add-skill-source/
│       │   └── SKILL.md
│       ├── add-sops-secret/
│       │   └── SKILL.md
│       └── bump-opencode/
│           └── SKILL.md
├── .envrc
├── .pre-commit-config.yaml
├── .sops.yaml
├── AGENTS.md
└── README.md
```

Each personal skill under `modules/home/agents/skills/` contains a `SKILL.md`
plus optional `references/`, `assets/`, and `tests/` folders.

## Directory Guide

| Path | Contents | Purpose |
| --- | --- | --- |
| `flake.nix` | Inputs, packages, checks, and `darwinConfigurations.darwin` | Main evaluation entry point. |
| `flake.lock` | Locked input revisions | Reproducible builds. |
| `flake/` | `activate.nix`, `devshell.nix`, `git-hooks.nix`, `hosts.nix` | Activation app, development shell, Git hooks, and host values. |
| `hosts/darwin/` | `default.nix` | macOS host entry that imports system modules and Home Manager. |
| `modules/darwin/` | `default.nix`, `mcp.nix` | System configuration, Homebrew, fonts, and MCP rendering. |
| `modules/home/` | Domain modules | User environment managed by Home Manager. |
| `modules/home/agents/` | OpenCode, RTK, and skills | Agent tooling and instruction sources. |
| `modules/home/editor/` | Neovim/nixvim modules | Editor, languages, formatting, and tests. |
| `modules/home/nix/` | `default.nix` | Installs the repository `nxc` CLI. |
| `modules/home/packages/` | `default.nix` | Permanent user packages. |
| `modules/home/security/` | `default.nix` | sops-nix and age key configuration. |
| `modules/home/shell/` | `default.nix`, `starship.toml` | zsh, prompt, history, and CLI integrations. |
| `modules/home/terminal/` | `default.nix`, `ghostty.conf` | Ghostty terminal configuration. |
| `modules/home/vcs/` | `git.nix` | Git settings and credential helper. |
| `pkgs/` | Custom derivations | Packages exposed by the flake. |
| `secrets/` | `secrets.yaml` | sops-encrypted secrets; never commit plaintext. |
| `docs/` | Project documentation | Detailed references such as this page. |
| `.agents/skills/` | Repository maintenance skills | Repeatable maintenance workflows. |
| `AGENTS.md` | Repository instructions for agents | Scope, checks, and boundaries. |
| `README.md` | Project overview | Setup, commands, and workflows. |

## Module Map

| Module | Responsibility |
| --- | --- |
| `modules/darwin/default.nix` | macOS host configuration, Homebrew casks, and fonts. |
| `modules/darwin/mcp.nix` | Shared MCP server definitions; renders OpenCode, Codex, and Antigravity configs from sops placeholders. |
| `modules/home/default.nix` | Imports every Home Manager domain. |
| `modules/home/agents/default.nix` | Imports OpenCode, RTK, and skill configuration. |
| `modules/home/agents/opencode/default.nix` | OpenCode CLI configuration. |
| `modules/home/agents/rtk.nix` | Renders global `AGENTS.md` files for OpenCode and Codex. |
| `modules/home/agents/skills.nix` | Skill sources and agent targets. |
| `modules/home/editor/default.nix` | Nixvim core configuration. |
| `modules/home/editor/languages.nix` | LSP, completion, formatting, and Tree-sitter setup. |
| `modules/home/editor/testing.nix` | Neotest adapters and test keymaps. |
| `modules/home/nix/default.nix` | Installs `nxc` from the flake. |
| `modules/home/packages/default.nix` | Permanent packages and custom flake packages. |
| `modules/home/security/default.nix` | sops-nix, age key, and related packages. |
| `modules/home/shell/default.nix` | zsh, Starship, Atuin, direnv, fzf, zoxide, and aliases. |
| `modules/home/terminal/default.nix` | Installs the Ghostty configuration file. |
| `modules/home/vcs/git.nix` | Git settings and the sops-backed credential helper. |

## How Modules Are Wired

`flake.nix` imports `flake/hosts.nix`, exposes packages and checks, and builds
`darwinConfigurations.darwin`. The host entry at `hosts/darwin/default.nix`
imports `modules/darwin` and wires Home Manager to `modules/home`.
`modules/home/default.nix` imports each user domain, and each domain's
`default.nix` imports its own submodules.

New modules therefore belong in the matching domain folder and must be imported
from that folder's `default.nix`.

## Where to Make Changes

| Change | Edit |
| --- | --- |
| Add a user package | `modules/home/packages/default.nix` |
| Add a Home Manager module | Create it under `modules/home/<domain>/` and import it from that domain's `default.nix`. |
| Add a system module | Create it under `modules/darwin/` and import it from `modules/darwin/default.nix`. |
| Add a custom package | Create it under `pkgs/<name>/` and expose it in `flake.nix`. |
| Change MCP servers | `modules/darwin/mcp.nix` |
| Add an agent skill source | `modules/home/agents/skills.nix` |
| Add a personal skill | `modules/home/agents/skills/<name>/SKILL.md` |
| Add a secret | Follow the sops workflow, then reference `config.sops.placeholder."<section>/<key>"`. |
| Change host values | `flake/hosts.nix` |
| Change CLI behavior | `pkgs/nxc/default.nix` |
| Update project docs | `README.md` or `docs/` |
