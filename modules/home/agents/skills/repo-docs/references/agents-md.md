# AGENTS.md

Instructions for coding agents working in the repo. The reader is an agent, not a person, so this document ignores the style choice: it is always plain and always in English, whatever the repo's other docs use.

## Delegate the Writing Rules

If the `writing-for-agents` skill is available, read it and follow its rules for how to write agent-facing text. This file only adds what is specific to AGENTS.md. If that skill is unavailable, follow the minimal rules below.

## What to Include

Include only what an agent cannot easily infer from the code. Each item must be grounded in files that were read or in what the user said.

1. **One-Line Project Summary.**
2. **Commands.** Install, run, build, test (including how to run a single test), lint, and format, with exact flags, taken from manifests and task runners.
3. **Layout.** Only the non-obvious parts of the directory structure.
4. **Conventions.** Formatter and linter configuration, naming, patterns, and architecture rules visible in the existing code and config.
5. **Boundaries.** Things not to touch or do, such as generated files, migrations that must not be edited, or commands that must not run against production. Include only those evidenced in the repo or stated by the user.
6. **Testing Expectations.** What must pass before a change is done.
7. **Pointers.** Links to deeper docs instead of copying them.

## Form

- No emoji, alerts, badges, diagrams, tables of contents, or marketing prose.
- Short imperative sentences. Prefer a command in a code block over a description of it.
- Keep it as short as the facts allow. Leave out anything an agent would find by reading the code.
- Do not invent rules. If a convention is unclear, leave it out or add a TODO comment.

## Notes

- If the repo already keeps a `CLAUDE.md` or similar file, leave it alone unless asked.
- For an existing AGENTS.md, apply the surgical-update rules in `SKILL.md`.
