# Commit Messages

Read when drafting or editing commit messages. Inspect the relevant changes and available repository conventions; use supplied changes when no repository is available. Do not infer a feature or rationale from a filename alone.

Use Conventional Commits by default: `type: description` or `type(scope): description`. Explicit instructions and enforced repository rules take precedence. Match the repository's type, scope, and issue-reference vocabulary where applicable.

Write the type, scope, and ordinary subject/body prose in lowercase. Preserve exact casing in literal identifiers, paths, names, acronyms, quotations, issue IDs, and required footer tokens. Lowercase is this skill's preference, not a requirement of Conventional Commits.

Choose the type from the actual change: `feat` for a feature, `fix` for a bug fix, and appropriate types such as `docs`, `refactor`, `test`, or `chore` for other work. Add a scope when it identifies a meaningful affected area; omit it when no useful scope applies. Scope is optional.

Describe the change precisely with a concise imperative subject and no trailing period. Do not impose a universal subject-length limit. Mark breaking changes with `!` immediately before the colon, or an uppercase `BREAKING CHANGE:` footer explaining the incompatibility and required action. Follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/).

Add a body when it explains a non-obvious reason, behavior change, compatibility requirement, or meaningful limitation. A tiny obvious change can have only a subject.

Keep the message in normal prose. Avoid dramatic fragments, release-note marketing, unrelated change summaries, or validation claims unsupported by actual checks. Describe what the commit changes rather than promising future work.

Return the message without prefatory commentary when only a message is requested. Drafting a message does not authorize committing, staging, or pushing.

## Examples

Without scope:

```text
docs: clarify setup instructions
```

With scope:

```text
fix(cache): refresh expired entries before returning results
```

Breaking change with a body and footer:

```text
feat(config)!: replace the legacy timeout setting

use timeout_seconds instead of timeout_ms.

BREAKING CHANGE: convert configured timeout values from milliseconds to seconds.
```
