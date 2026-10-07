# Release History Fixture

## Release Evidence

- Confirmed release: `v2.0.0`, released 2026-10-02. Deployment state was not supplied.
- Included change R1: export jobs now retry at most twice after a timeout. Other errors are not retried.
- Included change R2: `EXPORT_TIMEOUT_SECONDS` replaces `EXPORT_TIMEOUT_MS`. Operators must convert milliseconds to seconds before upgrading. The default remains 30 seconds; a previous value of 5000 milliseconds becomes 5 seconds.
- R3: an internal refactor changes no supported behavior.
- R4: CSV streaming is merged after the `v2.0.0` tag and is not included in that release.
- R5: pagination is an open proposal, not implemented or approved.
- No benchmark or speed measurement was supplied.

## CHANGELOG.md

```markdown
# Changelog

## Unreleased

## v1.9.0 - 2026-09-18

### Fixed

- Preserve column order when exporting filtered results.
```

The user requests release notes for operators for `v2.0.0`, plus an updated changelog containing that release and the confirmed unreleased change. Source records R1-R5 are supplied notes, not fabricated GitHub URLs.
