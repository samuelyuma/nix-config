# Release Notes and Changelog

Release notes tell users what changed and what they must do. A changelog is the chronological record. Link the two instead of duplicating every detail. First establish the release boundary (which versions or tags), the audience, and the release state.

## Evidence

Use history inside the boundary and read the code when a change's effect is unclear. A merged commit is proof of integration, not of release or deployment. Never invent a version, date, or measurement. A performance claim with a number needs a source measurement.

## Release Notes

1. **Release Identity and Status.** Confirmed version and date, or a visible Draft marker.
2. **User Impact.** The most important improvements, fixes, and behavior changes first.
3. **Breaking Changes and Migration.** Who is affected, prerequisites, required steps, compatibility limits. Keep conditions and units exact.
4. **Known Issues.** Evidenced limitations and supported workarounds.
5. **References.** Links to changes or the changelog.

Group by user impact, not by commit subject. Keep internal refactors only when the audience cares. Pending changes belong in an Upcoming or Draft section, never among released features. For security advisories, link the published advisory and do not add details.

## Changelog

- Keep the existing format, version order, categories, and history. Use an existing Unreleased section for unconfirmed releases.
- Use categories (Added, Changed, Deprecated, Removed, Fixed, Security) only when they help and match the file.
- Record each observable change once. Group related commits.
- Keep breaking behavior and migration visible; link to the migration guide if there is one.
- Add a version, date, or comparison link only from confirmed evidence, and check the tags exist.
- Change published entries only for a requested correction.
