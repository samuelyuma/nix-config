---
name: agent-instructions
description: Create, review, and update AGENTS.md or equivalent agent instruction files for a repository, directory, or global setup. Keeps only rules that change how an agent works, checks them against the real repo, and verifies scope and ownership. Not for SKILL.md authoring, human README files, or general documentation.
---

# Agent Instructions

Use for `AGENTS.md`, `CLAUDE.md`, and similar files that tell an agent how to work in a repository. Read `references/instructions.md` and follow it. Paths are relative to this skill.

Fixed rules:

- Find the maintained source file. Do not edit generated files or store symlinks.
- Keep only rules that change what the agent does: unusual commands, required checks, boundaries, generated-file ownership, known footguns. Remove generic advice ("write clean code").
- Verify each rule against the repo: scripts, task runner, config. Do not invent commands.
- Keep existing permissions, required checks, and valid handwritten rules unless the user asks to change them. Report conflicts instead of silently weakening a rule.
- Do not claim the agent loaded the file. A valid file or a successful build does not prove loading.
- Library or tool behavior claims: verify with `research/references/library-docs.md` when available.
- Wording follows the `writing` skill. A human README belongs to the `documentation` skill.
