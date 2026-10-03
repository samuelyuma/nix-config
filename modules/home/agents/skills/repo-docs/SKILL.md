---
name: repo-docs
description: Write or update repository documentation of four types - a root README, a README documenting an existing feature, a README documenting a workflow (deployment, release, CI/CD, application or data flow), and AGENTS.md. Use whenever the user asks to create, write, draft, update, refresh, or fix any of these, for example "write a README for this repo", "document the auth feature", "document our deploy pipeline", "update the README, it is outdated", "write an AGENTS.md". Do not use for small markdown edits (typos, one paragraph), CHANGELOG files, code comments, API references generated from code, or any document that is not one of the four types.
---

# repo-docs

Produce documentation that is accurate first and readable second. A polished README with a wrong command or an invented architecture does more harm than a rough one, so everything written here must be traceable to something actually read in the repository.

## Workflow

Follow these steps in order.

### 1. Identify the Document Type

| Type | Signals | Read |
|---|---|---|
| Root README | "README", the root `README.md`, project overview | `references/root-readme.md` |
| Feature README | "document the X feature", docs for existing functionality | `references/feature-readme.md` |
| Workflow README | deployment, release, CI/CD, pipeline, application flow, data flow | `references/workflow-readme.md` |
| AGENTS.md | "AGENTS.md", instructions for coding agents | `references/agents-md.md` |

Read only the reference for the matching type. If the request fits none of the four, stop using this skill and say so.

For every human-facing type (the first three), also read `references/rich-elements.md` before writing. AGENTS.md skips it.

### 2. Resolve Style and Language

Both are decided by the same precedence order. Take the first one that applies:

1. The explicit request ("plain", "no emoji", "with emoji", "in Indonesian").
2. The existing docs in the repo (root `README.md`, `docs/`). Emoji in headings or bullets means Emoji style. The dominant language of their prose is the language.
3. The default: **Plain** style, **English** language.

An explicit request that contradicts the existing docs is followed without a warning. It is the user's decision.

AGENTS.md ignores this step. It is always plain and always English.

Style rules:

- **Plain**: no emoji or pictographs anywhere. Write "Yes" and "No" instead of check marks in tables. Alert icons are drawn by GitHub itself and are allowed.
- **Emoji**: at most one emoji, only at the start of an H2 heading. None in body text, tables, H3 or deeper headings, code, or commands. Use the same small set consistently.

Language rules: write the whole document in one language. Never translate commands, file names, identifiers, code, or established technical terms (pipeline, rollback, endpoint).

Heading rule: write every heading in Title Case, as in "How to Migrate" or "When to Use the SDK?". Capitalize the major words, keep articles, conjunctions, and short prepositions lowercase unless they come first or last, and keep acronyms and identifiers as written. This applies to all four document types, AGENTS.md included, and to the section names in the reference skeletons. In another language, capitalize the major words the same way. When updating an existing doc, apply it to headings you write or edit, leave other headings untouched, and say so in the report.

Style does not decide whether diagrams, tables, or alerts appear. Both styles use them under the same rules in `references/rich-elements.md`.

### 3. Read the Repository

Do not write before reading. Look at what the document type needs, and at minimum:

- Manifests and lockfiles: `package.json`, `go.mod`, `pyproject.toml`, `Cargo.toml`, `flake.nix`, and similar.
- Task runners: `Makefile`, `justfile`, `package.json` scripts, `Taskfile`.
- CI and deploy: `.github/workflows/`, `Dockerfile`, `docker-compose*`, deploy scripts.
- Config: `.env.example`, config files, formatter and linter configs.
- Directory layout and entry points.
- Existing docs, to detect style, language, and conventions.
- For a feature: its code, routes, tests. For a workflow: the workflow files and the scripts they call.

If the repo has no usable evidence for a section, leave the section out or mark it with a TODO. Padding it with plausible text is the failure this skill exists to prevent.

### 4. Create or Update

- Target file does not exist: create it from the reference skeleton, adapted to what was found.
- Target file exists: do a **surgical update**. Keep its structure, voice, and hand-written content. Change only what is provably stale or missing. Never delete hand-written content unless asked.
- Full rewrite only on explicit request ("rewrite from scratch"). Then state which old content was not carried over.
- Mixed-style doc: apply the requested style only to the parts you touch, and say in one sentence that the rest was left alone.

### 5. Write Under the Grounding Rules

- Every command comes from a manifest, task runner, or config that was read. Never write a command because it is typical for the stack.
- Every diagram is drawn from code or workflow files that were read, not from how such systems usually work.
- Anything that cannot be grounded gets a marker in this exact form: `<!-- TODO: confirm default port -->`.
- Document what and how. Do not invent the reason behind a design decision. If the reason is not written down in the repo, leave a TODO such as `<!-- TODO: why blue-green? -->` or leave it out.
- Never print secret values. Document names of secrets and variables only.

### 6. Verify Before Finishing

- Every command and path mentioned exists or is produced by something that exists.
- Relative links resolve.
- Mermaid syntax is valid. Use `mmdc` if it is installed, otherwise re-read each diagram against the syntax notes in `references/rich-elements.md`.
- At most 3 alerts, and one diagram per flow.
- Plain style contains no emoji. Emoji style follows the one-per-H2 rule.
- One language throughout.

### 7. Report

End with a short report, a few lines:

- What was created or changed. For an update: added, changed, removed.
- The TODO markers left, in one sentence.
- Only if alerts or Mermaid were used: they render on GitHub but may not in other previews, so check on GitHub.
