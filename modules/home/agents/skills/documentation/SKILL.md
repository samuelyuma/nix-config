---
name: documentation
description: Create, update, and review technical documents such as API specs, design docs and proposals, READMEs, workflow guides, release notes, changelogs, status reports, and research reports. Gathers evidence, asks about material gaps, and verifies the result. Not for SKILL.md or AGENTS.md files, generated API references, or wording-only cleanup.
---

# Documentation

Owns document type, structure, coverage, clarification, and verification. Sentence-level wording belongs to the `writing` skill (use it if available; read its Indonesian file for Indonesian output). Agent instruction files (AGENTS.md and similar) belong to the `agent-instructions` skill.

## Start

Decide three things before writing: who reads it, what decision or action it supports, and which document type it is. Then read the matching reference. Paths are relative to this skill.

| Document | Read |
|---|---|
| API spec, endpoint contract, event protocol | `references/api-spec.md` |
| Design doc, proposal, decision record | `references/design-doc.md` |
| README (project or feature) | `references/readme.md` |
| Deployment, CI/CD, operational or app workflow | `references/workflow-guide.md` |
| Release notes or changelog | `references/release.md` |
| Weekly or status report | `references/reports.md` |
| Research findings | `references/research-reports.md` |
| Missing facts or conflicting evidence | `references/clarifying.md` |
| Table, diagram, alert, collapsible | `references/rich-elements.md` |
| Before delivering anything | `references/verification.md` |

Do not read all references. Most tasks need the type file plus `verification.md`.

## Fixed Rules

- **One document, one audience, one purpose.** If the content mixes contract, frontend behavior, and backend implementation, split it into sections for each audience or into separate files.
- **Decisions first.** Put open decisions in one section near the top ("Decisions Needed"), then link to the sections they affect. Do not bury a decision in a paragraph.
- **Self-contained.** A new reader must understand it without chat history. Name things instead of writing "the current handler" or "the previous plan".
- **Process evidence stays in chat.** Test results, which files were inspected, and what could not be checked go in the reply, not in the document. A report document is the exception.
- **Evidence over memory.** Read the code, config, and sources for every command, number, and behavior. Mark gaps as unknown. Never invent owners, dates, or results.
- **Keep what works.** In updates, keep existing structure, language, handwritten content, and citations unless a rewrite was requested. Report meaningful removals.
- **Language.** An update keeps the document's language. A new document follows an explicit request, then the language of nearby docs, then the user's message. Chat replies follow the user's current message.
- **Library facts.** Verify API or config claims about a library with `research/references/library-docs.md` before writing them.
- **Long contracts or heavy reasoning.** For a document whose structure is unclear, a short pass with the sequential thinking tool (see `plan/references/structured-thinking.md`) can help outline it. Do not paste the reasoning into the document.

Documentation work does not authorize implementation, deployment, or publishing.
