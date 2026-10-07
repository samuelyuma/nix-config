---
name: documentation
description: Create, update, and review human-facing READMEs, feature and workflow guides, release notes, changelogs, weekly or status reports, research reports, and proposals. Organize available evidence, clarify meaningful gaps, and verify the document. Exclude agent instructions, generated API references, and isolated wording fixes.
---

# Documentation

Own document structure, coverage, clarification, and verification. Use the user's `writing` skill and its document reference when available for prose; otherwise use clear, concise language. This skill works without external skills. Substantial investigation and website generation are separate tasks.

## Choose the Document

Identify audience, purpose, destination, and whether the request is creation, updating, or review. Read only the matching reference; paths are relative to this skill.

| Document | Reference |
|---|---|
| Project overview and onboarding | `references/root-readme.md` |
| Existing feature | `references/feature-readme.md` |
| Operational or application workflow | `references/workflow-guide.md` |
| Release announcement | `references/release-notes.md` |
| Versioned change history | `references/changelogs.md` |
| Weekly or status report | `references/reports.md` |
| Research findings | `references/research-reports.md` |
| Proposed work or decision | `references/proposals.md` |

Treat skeletons as options. Include sections that serve the reader, omit irrelevant ones, and mark necessary gaps.

## Gather Evidence and Clarify

Read relevant implementation, configuration, history, existing documents, supplied notes, and cited sources. Inspect only material needed for the task. Distinguish verified facts, user decisions, proposals, and unknowns. Never read or reproduce secret values; document configuration names from safe sources.

Ground commands, metrics, rationale, release status, plans, blockers, and validation claims in evidence. Cite implementation or external sources where readers need to verify a claim. Separate substantial new investigation from drafting; agree its scope when required.

For missing facts, unclear decisions, or conflicting evidence that affects the result, read `references/clarifying.md`. Ask focused rounds after checking available sources, label recommendations, and incorporate answers. Keep unanswered material questions visible in working drafts. An optional unsupported claim can be omitted; an important unresolved claim keeps the document a draft.

## Write or Update

Follow the requested destination, otherwise existing conventions. Ask about placement only when the choice matters. Keep useful structure and handwritten content during focused updates. Reorganize when requested; rewrite fully only when requested. Report meaningful removals.

Updates retain the document's language unless translation is requested. New documents use explicit language, then surrounding document conventions, then the current user message. Chat follows the user's language. Keep identifiers and commands exact; use Title Case for headings you write.

Read `references/rich-elements.md` when a table, diagram, alert, collapsible section, badge, or contents list improves reading. Required instructions stay visible. Use ordinary prose rather than decorative formatting.

## Verify and Deliver

Read `references/verification.md` before completion. Check claims, paths, links, commands, and any diagrams against evidence. Distinguish checks actually run from suggested checks. Deliver the document, summarize meaningful changes, and identify unresolved questions or verification limits.

The `tests/` directory is for maintainers, not routine documentation.
