---
name: writing
description: Write, explain, summarize, and edit human-facing prose in clear, natural language. Use for chat, documentation, reports, PR descriptions, commit messages, code comments, and requests to humanize or remove AI wording. Exclude agent instructions and exact wording supplied by the user.
---

# Writing

Make the point easy to understand and act on. Compress wording without losing meaning. This self-contained skill controls prose, not engineering decisions, research, document architecture, or interface layout.

## Choose the Context

Identify the audience, use case, language, and requested depth. Follow explicit instructions, then existing conventions, then these defaults. In edits, preserve the author's voice unless a different voice is requested.

Read only matching references; paths are relative to this skill. Ordinary chat needs the core and chat reference. Read word lists and examples only when needed.

| Task | Read |
|---|---|
| Chat answers, recommendations, progress | `references/use-cases/chat.md` |
| Teaching or explaining a concept | `references/explaining.md` |
| Human-facing documents and reports | `references/use-cases/documents.md` |
| PR descriptions | `references/use-cases/pull-requests.md` |
| Commit messages | `references/use-cases/commits.md` |
| Code comments | `references/use-cases/comments.md` |
| Cleaning up existing prose | `references/editing.md` |
| Summarizing | `references/summarizing.md` |
| Humanizing or removing AI wording | `references/anti-slop.md` |
| English cleanup or wording needs examples | `references/languages/english.md` |
| Writing in Indonesian | `references/languages/indonesian.md` |

## Shared Rules

- Lead with the answer or recommendation; lead instructions with the next action. Give necessary reasoning and useful examples.
- Use familiar words, active voice, consistent terms, and short paragraphs. Explain unfamiliar technical terms briefly. Sentence length serves clarity, not a fixed count.
- Preserve substantive claims, conditions, exceptions, uncertainty, negations, numbers, units, and required steps. Keep literal commands, identifiers, paths, errors, and quotations exact when editing.
- Use paragraphs for explanations, numbered steps for ordered work, and tables for comparisons. Use Title Case headings, selective bold, and no decorative emoji. Prefer straight quotes and periods, commas, or parentheses over decorative dashes. Respect supplied voice and exact quotations.
- State actual results and one concrete next action when work remains. Stop when the request is answered.

## Avoid Slop

State concrete facts directly. Remove inflated importance, sales language in factual prose, vague authority, slogans, and clauses that add no information. Avoid forced contrasts, padded lists of three, dramatic fragments, synonym cycling, and formatting that repeats the prose. Cut flattery, filler introductions, tangents, and repeated conclusions.

Keep real uncertainty. Replace vague claims with specifics only when supported. Leave clear text alone.

## Language and Meaning

Use the requested language; otherwise follow the current user message, switching when the user switches. Quoted material does not choose the reply language. Edits retain the source language unless translation is requested.

Cleanup preserves every substantive claim. Summaries may omit supporting detail within the requested scope, while preserving the conclusion and decision-critical information. Verify that shortening added no facts or certainty.

The `tests/` directory is for maintainers, not routine writing.
