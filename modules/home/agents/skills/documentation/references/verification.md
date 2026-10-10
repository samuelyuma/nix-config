# Verification

Check the result against the request and document type before delivery. Verify correctness before polish.

## Evidence and Meaning

- Trace each consequential claim to inspected code, supplied information, or a source. Keep inference, decisions, proposals, and unknowns distinguishable.
- Check release and report boundaries. Keep conditions, exceptions, negations, numbers, units, and required order.
- Updates must keep useful handwritten content and citations. Explain meaningful removals.
- Keep material unknowns visible and label the document Draft when they affect correctness. Remove a marker only when resolved. Missing evidence is not proof of absence.

## Structure Check

- Is there one audience and one purpose? If not, split.
- Are open decisions in one place near the top, linked to affected sections?
- Does every rule say who acts and how strict it is (must, should, may)?
- Can a new reader follow it without chat history?
- Is process evidence (test results, inspection notes) absent from the document?

## Commands and Links

- Check commands and flags against task definitions, help output, config, or authoritative sources. Check prerequisites, working directory, and order.
- Check paths relative to the destination file. Resolve local links and anchors. Check external links when practical.
- Run safe, relevant checks when allowed. Do not run destructive, deployment, or external-write steps just to validate documentation. Report commands inspected separately from commands run.
- Follow the repository's required checks after file changes and report failures honestly.

## Presentation and Delivery

Check headings, fences, tables, and collapsibles. Check diagrams against the evidence with a renderer or parser if available. A manual read of Mermaid is not a rendering test.

For library or framework claims, confirm them with `research/references/library-docs.md`.

Deliver to the requested place. In the reply, say what changed, what was removed on purpose, what is still open, and which checks actually ran. Do not call a document ready when material gaps remain. Deliver it as a Draft.
