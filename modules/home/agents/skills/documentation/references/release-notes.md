# Release Notes

Explain what changed for users in a specific release and what action they need to take. Establish the release/version boundary, audience, and release state from supplied notes, tags, releases, or other relevant evidence.

## Evidence

Use history within the requested boundary and inspect implementation where a change's effect is unclear. A merged commit is evidence of integration, not proof of deployment or release. Confirm which changes are included. Preserve an existing versioning convention; never manufacture a release version or date.

## Flexible Skeleton

1. **Release Identity and Status.** Use a confirmed version/date, or visibly mark a draft boundary.
2. **User Impact.** Lead with the most consequential improvements, fixes, or changed behavior.
3. **Breaking Changes and Migration.** Include affected users, prerequisites, required steps, and relevant compatibility limits when supported.
4. **Known Issues.** List evidenced limitations and supported workarounds.
5. **References.** Link source changes or a full changelog where useful.

Group by reader impact rather than dumping commit subjects. Keep internal refactors only when relevant to the audience. Preserve security advisories' disclosure scope and link the published advisory rather than inventing details.

A pending change belongs in an explicitly upcoming/draft section, not among released features. Distinguish implemented behavior from measured outcomes; performance improvements need evidence for any numeric claim.
