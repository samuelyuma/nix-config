---
name: plan
description: Create, review, and update implementation plans for repository features, bug fixes, refactors, migrations, and configuration changes. Grounds steps in current code, collects open decisions in one place, and defines how to verify. Not for general schedules, research-only questions, or rewriting a settled plan's wording.
---

# Plan

Turns a repository problem into ordered, verifiable work. Answer in chat unless a file is requested. This skill plans; it does not implement unless the user also asked for that.

## Start

Identify the desired behavior, constraints, exclusions, and mode (create, review, update). Read repository instructions, the relevant code, config, tests, and supplied findings. Verify that paths and commands exist. Label new files as new. Then read what matches. Paths are relative to this skill.

| Situation | Read |
|---|---|
| Any new plan (the output shape) | `references/plan-format.md` |
| Bug, unexplained failure, performance regression | `references/diagnosis.md` |
| User supplied a plan to review or update | `references/reviewing.md` |
| Several milestones, migration, cross-module change | `references/complex-work.md` and `references/structured-thinking.md` |
| Many dependencies or competing hypotheses | `references/structured-thinking.md` |
| Plan relies on a library or framework API | `research/references/library-docs.md` |
| Before delivering | `references/verification.md` |

## Fixed Rules

- **Open decisions go in one section near the top**, each with a recommendation, then are marked at the steps they affect. Never leave a decision only inside a step.
- Ask a question only when the answer changes scope, behavior, or approach and the repo cannot answer it. Number the questions and give a recommendation for each. Carry answers forward.
- Choose the smallest approach that works. Keep agreed decisions unless new evidence challenges them.
- Each step names the change, the files or modules, dependencies when needed, and an observable completion check. Prerequisites come first.
- Keep implementation detail short. If the plan needs a full API contract or design rationale, write it in a document (`documentation/references/api-spec.md` or `design-doc.md`) and link to it.
- An unresolved cause gets investigation steps and a decision point. Do not assert a fix.
- Checks run during planning, and their results, go in the chat reply. The plan contains acceptance criteria and checks to run later.
- Wording follows the `writing` skill. The plan stays in the language of an existing plan unless translation is requested.

Planning-only requests end with the plan. Authorizing implementation separately does not add permissions beyond what the user granted.
