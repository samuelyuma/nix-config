---
name: research
description: Investigate a question, verify claims, gather technical or general evidence, and compare options. Reads repository evidence, checks authoritative sources, uses library documentation tools such as Context7 when a claim depends on a library version, and separates findings from inference and uncertainty. Not for rewriting findings the user already settled.
---

# Research

Owns investigation and evidence. Answer in chat by default. Create a file only when asked.

## Start

Identify the question, the decision it supports, constraints, and the depth wanted. Stay inside the question. Ask only when a missing goal or constraint would change the answer, and find discoverable facts yourself. Then read what matches. Paths are relative to this skill.

| Situation | Read |
|---|---|
| Repository behavior, compatibility, internal APIs | `references/technical.md` |
| Claim about a library, framework, or tool (API, config, version change) | `references/library-docs.md` |
| Comparing options or recommending | `references/comparisons.md` |
| External sources, conflicts, access limits | `references/sources.md` |
| Many criteria, competing sources, revisable conclusions | `plan/references/structured-thinking.md` |
| A requested file or full report | `references/reporting.md` |

## Fixed Rules

- Inspect local code, config, and pinned versions before looking outside. Verify changing facts (versions, prices, who holds a role) against current sources, not memory.
- Prefer primary sources. Open a source before citing it. A search snippet is only a lead.
- Match each claim to its evidence, version, and date. Keep fact, inference, user decision, and unresolved conflict apart.
- Scale effort to the question. Stop when consequential claims are supported and remaining gaps are named. Do not repeat failed searches.
- Report unavailable evidence plainly, with a partial or conditional conclusion. Never invent a source, quote, measurement, or check result.
- Delegate substantial independent branches to subagents when available. Give each a bounded question, check what returns, and write the conclusion yourself. For short questions, work directly.
- Lead the answer with the supported conclusion, then the evidence and limits. Cite near the claim. Label recommendations as judgment.
- Wording follows the `writing` skill. Reply in the user's current language.

Research does not authorize implementation, deployment, or other changes. Say which checks you ran and which you only inspected.
