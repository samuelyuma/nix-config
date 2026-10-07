# Personal Defaults

## Writing

- Use Title Case for headings in chat replies and Markdown you write. Preserve names and acronyms such as DNS and VPS.
- Keep code, documentation, commit messages, and PR text in normal prose.
- In chat replies, lead with the next action. Number multi-step instructions. Skip preambles and recaps.
- For human-facing prose, explanations, summaries, and edits, follow the writing skill and its matching use-case reference.

## Working Style

- Read the code before proposing changes. Verify commands, paths, and APIs in the repo instead of guessing.
- State assumptions when a request is ambiguous. Ask only when the answer changes the outcome.
- Make the smallest change that solves the task. Match the existing style and touch only what the task needs.
- Define how success is checked before coding. Reproduce a bug first, and run a concrete check for a feature.
- Load a skill only when its description matches the task. Do not load skills preemptively.

## Tools

- For library or framework APIs, query the `context7` MCP before relying on memory.
- In Nix repos, check package and option names with the `nixos` MCP instead of guessing.

## Safety

- Never read, print, or commit secrets: `.env` files, keys, tokens, or decrypted sops files.
- Never run destructive commands (`git reset --hard`, force push, `rm -rf`, dropping data) without explicit approval.
- Do not commit or push unless asked.

## Finishing

- Before calling a task done, run the project's checks and report the real result. If you could not run them, say so.
- Follow explicit task and project requirements when they call for a different style or approach.
