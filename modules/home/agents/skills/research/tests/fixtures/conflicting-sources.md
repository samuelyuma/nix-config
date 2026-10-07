# Conflicting Sources Fixture

All names and evidence below are invented for isolated tests. Both official snapshots concern Exporter 2.4.0 under its default configuration. Implementation and runtime results are unavailable.

## Source A: Release Notes Snapshot

Published 2026-10-01. The default retries timeout exports at most twice. Other errors are not retried.

## Source B: API Reference Snapshot

Published 2026-10-02. The default retries timeout exports exactly once. Other errors are not retried.

## Source C: Community Experience

A user says exports were not retried in a custom configuration. Their settings and version were not supplied. This is an anecdote about their experience, not documentation of the default.

## Request

Write a short Markdown research report about the default retry behavior of Exporter 2.4.0 using only the supplied snapshots. Save it to the requested report path. No implementation investigation, network access, or runtime execution is available. Do not require optional documentation or writing skills.
