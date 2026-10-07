# Meaning Preservation Fixtures

These are hypothetical facts for evaluation, not claims about this repository.

## Retry Policy

```text
Retry only read-only requests after a timeout. Do not retry a payment request unless the server confirms that it was not processed. Wait 5 seconds between attempts, with at most 3 retries. This may reduce transient failures; it does not guarantee success. Back up the database before the migration. If the backup fails, stop. The migration is merged but has not been released.
```

## PR Facts

```text
Previously, an expired cache entry was returned. The change fetches a fresh value when the entry expires. The cache test passed. The full suite was not run. No measured performance results are available. Draft a description only; do not publish it.
```

## Comment Facts

```python
deadline = started_at + timeout_seconds
while clock() < deadline:
    poll()
```

The deadline is computed once so each poll uses the original timeout budget. No other history or performance evidence is supplied.

## Weekly Report Facts

```text
The cache fix was merged on Tuesday but is not released. The retry work remains in progress. No test result, blocker, next-week plan, or productivity metric was supplied.
```
