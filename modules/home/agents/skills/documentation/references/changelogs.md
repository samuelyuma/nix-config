# Changelogs

Maintain a chronological, versioned record of notable changes. Read the current changelog and establish the requested release boundary before adding entries.

## Updating

- Preserve the existing format, version order, categories, and historical entries. Use an existing Unreleased section for changes whose release is unconfirmed.
- Use categories that describe the change, such as Added, Changed, Deprecated, Removed, Fixed, or Security, only when they help and match conventions.
- Record observable changes once. Group related commits instead of copying history verbatim.
- Keep breaking behavior and required migration visible; link detailed release notes or a migration guide when needed.
- Add a version, release date, or comparison link only from confirmed evidence. Check that tag and comparison targets exist.

For a new changelog, choose a simple structure compatible with the project's versioning. Unknown release metadata remains visibly unresolved in a draft; ordinary Unreleased entries do not require inventing it. Changing previously published entries should be limited to requested corrections with a clear reason.

Release notes explain impact for a particular audience; the changelog maintains history. Link the two where useful instead of duplicating every detail.
