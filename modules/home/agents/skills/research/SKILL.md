---
name: research
description: Investigate requested questions, verify claims, gather technical or general evidence, and compare options. Inspect repository evidence, check authoritative sources, and distinguish findings from inference and uncertainty. Exclude merely rewriting supplied findings or creating documentation from settled facts.
---

# Research

Own investigation and evidence. Answer in chat by default; create a file when requested. This skill works without external skills or subagents.

## Frame the Question

Identify the question, intended decision, relevant constraints, and requested depth. Research the requested topic without expanding it into unrelated work. Ask about missing goals or constraints only when they change the outcome; find discoverable facts yourself. Label consequential assumptions and carry unanswered questions forward.

Read only matching references; paths are relative to this skill.

| Branch | Read |
|---|---|
| Repository behavior, APIs, technical compatibility | `references/technical.md` |
| Comparing options or recommending a choice | `references/comparisons.md` |
| External sources, conflicting evidence, or access limits | `references/sources.md` |
| Requested research file or full report | `references/reporting.md` |

## Investigate

For repository questions, inspect relevant local implementation, configuration, pinned versions, and tests before looking outside. Follow explicit source restrictions and environment-specific tool instructions. Verify changing facts against current evidence rather than memory.

Prefer primary sources for technical facts. Inspect sources before citing them; search snippets are leads. Match each consequential claim to supporting evidence and its relevant version, date, or conditions. Use forums as leads or attributed experience, not proof of technical behavior. Separate verified facts, inference, user decisions, and unresolved conflicts.

Scale effort to the question. Stop when consequential claims are supported and remaining gaps are clear; continue when a resolvable gap could change the answer. If important evidence is unavailable, report the limitation and a conditional or partial conclusion instead of inventing certainty. A fixed source count or repeated failed searches does not establish quality.

## Delegate When Useful

Handle short questions directly. When available and permitted, delegate substantial independent branches with a bounded question, constraints, and requested evidence. Check returned findings and resolve overlap or disagreement before synthesis. Remain responsible for the conclusion; delegation is optional.

## Deliver

Lead with the supported answer or recommendation, then the necessary evidence and limits. Cite consequential claims near the text they support. Label inference and recommendations; preserve conditions, exceptions, numbers, units, and uncertainty.

For prose, use the user's `writing` skill when available; otherwise use concise, natural language and Title Case headings. Follow the user's current language unless explicitly directed otherwise. Requested files follow `references/reporting.md`.

Research does not authorize implementation, deployment, or other external changes. Distinguish source inspection from checks actually run. The `tests/` directory is for maintainers, not routine research.
