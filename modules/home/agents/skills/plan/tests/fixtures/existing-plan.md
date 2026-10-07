# Existing Plan

Invented input for review or focused revision against `repository.md`.

## Agreed Decisions

- Add TSV through the existing `format` argument.
- Preserve input order and keep the public signature compatible.
- Preserve JSON and CSV behavior.

## Steps

1. Extend `src/exporter.py` to accept TSV.
2. Concatenate each item's values with a tab and join lines with a newline; quoting is unnecessary because current CSV export uses plain string concatenation.
3. Remove the JSON branch to simplify export maintenance.
4. Verify the work by checking that `export_items([], "csv")` still succeeds. Existing tests prove all batch operations are atomic.

## Progress

- [x] TSV regression tests pass. This is a status note from the plan's author; no command or result was supplied.
