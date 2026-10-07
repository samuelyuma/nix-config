# Repository Snapshot

Invented evaluation evidence. These are the complete relevant files in a small Python project, using only the standard library. Tests below are supplied source, not a claimed run result. Each fenced block is the content of its named file.

## AGENTS.md

```markdown
# Project Instructions

Use Python standard-library tools. Run `python3 -m unittest discover -s tests` for behavioral changes. Do not commit or push. Keep public function signatures compatible unless the user requests a change.
```

## README.md

```markdown
# Catalog

`catalog.export_items(items, format="json")` returns a string. Supported formats are `json` and `csv`. Each item has `name` and `price` fields. Export keeps input order and does not modify items. CSV includes a header. Unsupported formats raise `ValueError`.

`catalog.add_batch(existing, incoming)` adds validated items to an existing list. An item without a non-empty name is invalid. The batch operation should be atomic: rejected batches leave the original list unchanged.

Run checks with `python3 -m unittest discover -s tests`.
```

## catalog.py

```python
import csv
import io
import json


def export_items(items, format="json"):
    if format == "json":
        return json.dumps(items)
    if format == "csv":
        output = io.StringIO(newline="")
        writer = csv.DictWriter(output, fieldnames=["name", "price"])
        writer.writeheader()
        writer.writerows(items)
        return output.getvalue()
    raise ValueError("unsupported format")


def add_batch(existing, incoming):
    for item in incoming:
        if not item.get("name"):
            raise ValueError("name is required")
        existing.append(item)
    return existing
```

## tests/test_catalog.py

```python
import json
import unittest

from catalog import add_batch, export_items


class CatalogTests(unittest.TestCase):
    def test_json_export(self):
        items = [{"name": "pen", "price": 2}]
        self.assertEqual(json.loads(export_items(items)), items)

    def test_csv_export(self):
        self.assertEqual(export_items([], "csv"), "name,price\r\n")

    def test_unsupported_format(self):
        with self.assertRaises(ValueError):
            export_items([], "xml")

    def test_valid_batch(self):
        existing = []
        self.assertIs(add_batch(existing, [{"name": "pen"}]), existing)
        self.assertEqual(existing, [{"name": "pen"}])

    def test_invalid_first_item(self):
        existing = [{"name": "book"}]
        with self.assertRaises(ValueError):
            add_batch(existing, [{"name": ""}])
        self.assertEqual(existing, [{"name": "book"}])
```

## Feature Request

Plan TSV export support through the existing `format` argument. It should keep the same fields, header, order, and quoting behavior as CSV, using tabs as the separator. Preserve JSON and CSV behavior and rejection of other formats. Planning only; answer in chat.

## Bug Report

Adding a batch with a valid item followed by an invalid one raises `ValueError`, but the first item remains in the existing list. This violates the documented atomic behavior. Plan the fix; do not change source or tests.
