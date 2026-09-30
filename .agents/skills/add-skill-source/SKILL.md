---
name: add-skill-source
description: Add an external agent-skill repository to this nix-config. Use when asked to add, install, or enable skills from a GitHub repo.
---

# Add a skill source

1. Confirm the repo contains `SKILL.md` directories and their location.
2. In `flake.nix`, under Skill sources, add `<name> = { url = "github:<owner>/<repo>"; flake = false; };`.
3. In `modules/home/agents/skills.nix`, add `<name> = fromInput "<name>" [ "<skill-a>" "<skill-b>" ];` to `sources`. Use `<name>.input = "<name>";` only to enable the whole repo.
4. Stage changes, run `nix flake lock` or `nix flake update <name>`, then `nix flake check`.
5. Report enabled skill IDs. Do not activate; tell the user to run `nix run .#activate`.

Duplicate skill IDs across sources fail evaluation. Narrow the name list if needed.
