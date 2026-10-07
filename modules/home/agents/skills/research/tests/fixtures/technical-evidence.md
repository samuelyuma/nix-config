# Technical Evidence Fixture

All names and evidence below are invented for isolated tests.

## Question

Does the installed Exporter retry timeouts, and can I set the retry count? Answer in chat using only these supplied local artifacts. Do not change files or run an export.

## tool.lock

```text
exporter = 2.3.0
```

## src/export.ts

```typescript
export async function exportFile(path: string) {
  return transport.send(path, { timeoutRetries: 1 });
}
```

## docs/installed-api.md

Exporter 2.3.0 retries once after a timeout. It does not retry other failures. The exposed export interface accepts a path; it exposes no retry-count setting. This document matches the inspected implementation.

## docs/latest-api-snapshot.md

Supplied official documentation snapshot for Exporter 2.4.0: the export interface accepts an options argument with a timeoutRetries setting. Default: two timeout retries. No live page was supplied or checked.

## tests/export.test.ts

Supplied test expectation: Exporter 2.3.0 sends timeoutRetries equal to one. No test execution result was supplied.
