---
name: plan
description: Create, review, and update implementation plans for repository features, bug fixes, refactors, and configuration changes. Ground steps in current code, clarify consequential decisions, and define verification. Exclude general schedules, research-only questions, and merely rewriting settled plans.
---

# Plan

Turn a repository problem into actionable, verifiable work. Answer in chat unless a file is requested. This skill works without other skills or subagents; it owns planning, not implementation.

## Establish Scope and Evidence

Identify the desired behavior, constraints, exclusions, and requested mode: create, review, or update. Inspect relevant repository instructions, implementation, configuration, tests, and supplied findings. Verify existing paths and commands; label proposed new files. Keep observed behavior, user decisions, assumptions, and proposals distinct.

Read only matching references; paths are relative to this skill.

| Situation | Read |
|---|---|
| Bug fix, unexplained failure, or performance regression | `references/diagnosis.md` |
| Supplied plan to review or update | `references/reviewing.md` |
| Multiple milestones, migrations, or coordinated changes | `references/complex-work.md` |
| Acceptance criteria and checks, before delivering any plan | `references/verification.md` |

Resolve factual gaps through bounded inspection or investigation. Use the user's `research` skill when available for substantial investigation; otherwise gather supporting evidence directly. Follow source restrictions and environment tool requirements. Keep investigation proportional to what could change the plan.

For missing goals or decisions that change scope, behavior, or approach, ask focused numbered rounds with a recommendation. Find discoverable facts yourself. Carry answers forward; mark unresolved decisions beside affected steps. A blocked step need not block independent work.

## Build the Plan

Choose the smallest supported approach and explain meaningful tradeoffs. Preserve agreed decisions unless new evidence challenges them. Scale detail to the task; use milestones only when they improve execution.

Each step should give the intended change, relevant files or modules, dependencies where needed, and an observable completion check. Explain implementation details that prevent ambiguity; leave routine code edits to the implementer. Order prerequisites before dependent work.

Cover the outcome, scope, approach, ordered steps, verification, and consequential gaps without forcing a fixed template. For a small change, a short sequence can suffice. An unresolved cause gets investigation steps and a decision point, not an asserted fix.

## Deliver and Hand Off

Before delivery, check that consequential steps follow evidence, dependencies are ordered, and acceptance criteria cover the requested behavior. Label proposed checks separately from checks actually run. Distinguish work ready to implement from investigation or blocked decisions.

Use the user's `writing` skill when available; otherwise use concise prose, Title Case headings, and the current user language. Preserve an existing plan's language unless translation is requested.

A planning-only request ends with the plan. An already authorized implementation request may continue through the normal coding workflow. The plan grants no additional permissions. During implementation, adapt minor details to evidence; surface changes affecting agreed scope or behavior and resolve consequential choices before dependent work.

The `tests/` directory is for maintainers, not routine planning.
