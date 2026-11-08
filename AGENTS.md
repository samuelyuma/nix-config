# AGENTS.md

Nix-darwin + Home Manager flake for macOS (`aarch64-darwin`) and standalone
Home Manager for Linux (`x86_64-linux`), both for user `yumx`. Full
tree and module map: [docs/STRUCTURE.md](docs/STRUCTURE.md).

## Checks

Before finishing, run `nxc check` from the repository root. If `nxc` is not
available, run the commands in [README Checks](README.md#checks). On macOS, the
host build checks `darwinConfigurations.darwin.system`; on Linux, it checks
`homeConfigurations.linux.activationPackage`.

## Guardrails

- Ask the user to apply; agents never run activation (`nix run .#activate`,
  `nxc apply`, `darwin-rebuild switch`, or `home-manager switch`).
- Use `config.sops.placeholder."<section>/<key>"` for secrets; never open,
  decrypt, or edit `secrets/secrets.yaml`.
- Never run `sops updatekeys`, modify age private keys, or run sudo commands.
- Linux system services (Docker, Tailscale, T3 Code) stay under their official
  installers; do not add NixOS modules or root system services.
- T3 Code is managed by its official installer and updater, not Nix.
- Edit the Nix source; Home Manager's symlinks in `~` are read-only, including
  for `rtk init`.

## Nix Changes

- Search official docs and upstream first; prefer native declarative options.
  Explain any unavoidable custom workaround.
- Stage new files before evaluating; Nix only sees git-tracked files.
- Put modules in the matching domain folder and import them from its
  `default.nix`.
- Keep nixfmt formatting, remove unused arguments, and keep versions in Nix
  files; README and docs stay version-free.

## Sources

- Instructions: repo rules in this file; personal defaults in
  `modules/home/agents/global-agents.md` (copied by `rtk.nix`).
- Source files: `pkgs/nxc/default.nix` for `nxc`, `modules/shared/mcp-servers.nix`
  for shared MCP server definitions, `modules/darwin/mcp.nix` for macOS MCP
  rendering, and `modules/home/agents/mcp.nix` for Linux MCP rendering. Codex
  reads `/etc/codex/config.toml` on macOS and `~/.codex/config.toml` on Linux.
- Linux setup and VPS provisioning guide: [docs/LINUX.md](docs/LINUX.md).
- Maintenance skills:
  `.agents/skills/{bump-opencode,add-skill-source,add-sops-secret}/SKILL.md`.
