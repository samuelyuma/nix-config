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
│   ├── darwin/
│   │   └── default.nix
│   └── linux/
│       └── default.nix
├── modules/
│   ├── darwin/
│   │   ├── default.nix
│   │   └── mcp.nix
│   ├── shared/
│   │   └── mcp-servers.nix
│   └── home/
│       ├── default.nix
│       ├── agents/
│       │   ├── default.nix
│       │   ├── global-agents.md
│       │   ├── mcp.nix
│       │   ├── opencode/
│       │   │   └── default.nix
│       │   ├── rtk.nix
│       │   ├── rtk-codex.md
│       │   └── skills.nix
│       ├── editor/
│       │   ├── default.nix
│       │   ├── languages.nix
│       │   └── testing.nix
│       ├── nix/
│       │   └── default.nix
│       ├── packages/
│       │   ├── common.nix
│       │   ├── darwin.nix
│       │   ├── default.nix
│       │   └── linux.nix
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
│   ├── STRUCTURE.md
│   └── LINUX.md
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
├── LICENSE
└── README.md
```

Personal skills live in [agent-skills](https://github.com/samuelyuma/agent-skills).
The `personal-skills` flake input pins that repository, and
`modules/home/agents/skills.nix` selects the skills to install.

## Directory Guide

| Path | Contents | Purpose |
| --- | --- | --- |
| `flake.nix` | Inputs, packages, checks, `darwinConfigurations.darwin`, and `homeConfigurations.linux` | Main evaluation entry point. |
| `flake.lock` | Locked input revisions | Reproducible builds. |
| `flake/` | `activate.nix`, `devshell.nix`, `git-hooks.nix`, `hosts.nix` | Activation app, development shell, Git hooks, and host values. |
| `hosts/darwin/` | `default.nix` | macOS host entry that imports system modules and Home Manager. |
| `hosts/linux/` | `default.nix` | Linux host entry using standalone Home Manager. |
| `modules/darwin/` | `default.nix`, `mcp.nix` | System configuration, Homebrew, fonts, and macOS MCP rendering. |
| `modules/shared/` | `mcp-servers.nix` | Shared MCP server definitions used by macOS and Linux. |
| `modules/home/` | Domain modules | User environment managed by Home Manager. |
| `modules/home/agents/` | OpenCode, RTK, skills, and Linux MCP rendering | Agent tooling, instruction sources, and MCP configurations. |
| `modules/home/editor/` | Neovim/nixvim modules | Editor, languages, formatting, and tests. |
| `modules/home/nix/` | `default.nix` | Installs the repository `nxc` CLI. |
| `modules/home/packages/` | `common.nix`, `darwin.nix`, `linux.nix`, `default.nix` | User packages partitioned by platform. |
| `modules/home/security/` | `default.nix` | sops-nix and age key configuration. |
| `modules/home/shell/` | `default.nix`, `starship.toml` | zsh, Starship, Atuin, direnv, fzf, zoxide, and aliases. |
| `modules/home/terminal/` | `default.nix`, `ghostty.conf` | Ghostty terminal configuration. |
| `modules/home/vcs/` | `git.nix` | Git settings and credential helper. |
| `pkgs/` | Custom derivations | Packages exposed by the flake. |
| `secrets/` | `secrets.yaml` | sops-encrypted secrets; never commit plaintext. |
| `docs/` | Project documentation | Detailed references and the Linux setup guide. |
| `.agents/skills/` | Repository maintenance skills | Repeatable maintenance workflows. |
| `AGENTS.md` | Repository instructions for agents | Scope, checks, and boundaries. |
| `README.md` | Project overview | Setup, commands, and workflows. |

## Module Map

| Module | Responsibility |
| --- | --- |
| `modules/darwin/default.nix` | macOS host configuration, Homebrew casks, and fonts. |
| `modules/darwin/mcp.nix` | System-level MCP rendering on macOS (`/etc/codex/config.toml`, OpenCode, Antigravity). |
| `modules/shared/mcp-servers.nix` | Shared MCP server definitions converting sops placeholders into MCP config structures. |
| `modules/home/default.nix` | Imports every Home Manager domain. |
| `modules/home/agents/default.nix` | Imports OpenCode, RTK, skill configuration, and platform MCP rendering. |
| `modules/home/agents/mcp.nix` | User-level MCP rendering on Linux (`~/.codex/config.toml`, OpenCode, Antigravity). |
| `modules/home/agents/opencode/default.nix` | OpenCode CLI configuration. |
| `modules/home/agents/rtk.nix` | Renders global `AGENTS.md` files for OpenCode, Codex, and Antigravity. |
| `modules/home/agents/skills.nix` | Skill sources and agent targets. |
| `modules/home/editor/default.nix` | Nixvim core configuration. |
| `modules/home/editor/languages.nix` | LSP, completion, formatting, and Tree-sitter setup. |
| `modules/home/editor/testing.nix` | Neotest adapters and test keymaps. |
| `modules/home/nix/default.nix` | Installs `nxc` from the flake. |
| `modules/home/packages/default.nix` | Platform-aware package loader; imports `common.nix` and platform packages. |
| `modules/home/packages/common.nix` | Packages common to both macOS and Linux. |
| `modules/home/packages/darwin.nix` | Packages specific to macOS (Colima, Go toolchain, Antigravity ACP override, etc.). |
| `modules/home/packages/linux.nix` | Packages specific to Linux (Codex CLI). |
| `modules/home/security/default.nix` | sops-nix, age key, and related packages. |
| `modules/home/shell/default.nix` | zsh, Starship, Atuin, direnv, fzf, zoxide, and aliases. |
| `modules/home/terminal/default.nix` | Installs the Ghostty configuration file. |
| `modules/home/vcs/git.nix` | Git settings and the sops-backed credential helper. |

## How Modules Are Wired

`flake.nix` imports `flake/hosts.nix`, exposes packages and checks, and builds
`darwinConfigurations.darwin` for macOS and `homeConfigurations.linux` for the
Linux host.

On macOS, `hosts/darwin/default.nix` imports `modules/darwin` and wires Home
Manager to `modules/home`. On Linux, `hosts/linux/default.nix` configures
standalone Home Manager with `modules/home` directly.

`modules/home/default.nix` imports each user domain, and each domain's
`default.nix` imports its own submodules. `modules/home/packages/default.nix`
imports `common.nix` plus either `darwin.nix` or `linux.nix` based on the
configured host profile.

## Where to Make Changes

| Change | Edit |
| --- | --- |
| Add a shared user package | `modules/home/packages/common.nix` |
| Add a macOS user package | `modules/home/packages/darwin.nix` |
| Add a Linux user package | `modules/home/packages/linux.nix` |
| Add a Home Manager module | Create it under `modules/home/<domain>/` and import it from that domain's `default.nix`. |
| Add a macOS system module | Create it under `modules/darwin/` and import it from `modules/darwin/default.nix`. |
| Add a custom package | Create it under `pkgs/<name>/` and expose it in `flake.nix`. |
| Change MCP servers | `modules/shared/mcp-servers.nix` |
| Add an agent skill source | `modules/home/agents/skills.nix` |
| Add a personal skill | Add it to [agent-skills](https://github.com/samuelyuma/agent-skills), select it in `modules/home/agents/skills.nix`, and update the `personal-skills` input. |
| Add a secret | Follow the sops workflow, then reference `config.sops.placeholder."<section>/<key>"`. |
| Change host values | `flake/hosts.nix` |
| Change Linux host settings | `hosts/linux/default.nix` |
| Change CLI behavior | `pkgs/nxc/default.nix` |
| Update project docs | `README.md` or `docs/` |
