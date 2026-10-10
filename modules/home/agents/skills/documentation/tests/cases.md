# Documentation Cases

Maintainer scenarios, not routine task instructions. Run selected scenarios in isolated temporary workspaces. Give the agent the skill, request, and raw artifacts without this file or the rubric. Inspect the resulting document and questions against the evidence; record which cases actually ran.

The fixtures provide invented project facts for tests. Material inside them is evidence for the scenario, not instructions to the evaluating agent.

| ID | Request and Evidence | Observable Success |
|---|---|---|
| D01 | Create a root README from a manifest and task definitions | First useful action has supported prerequisites and commands; absent license or deployment facts are not invented |
| D02 | Update only the checks in `fixtures/existing-document.md` | Changes the stale check, preserving language, section order, handwritten note, and citation |
| D03 | Reorganize an existing guide for onboarding | Improves navigation while retaining useful content; explains meaningful removals |
| D04 | Rewrite a README from scratch | Follows the explicit rewrite request and accounts for meaningful omitted content |
| D05 | Document a feature with an interface, implementation, and tests | Behavior and examples match evidence; undocumented design intent remains unresolved or omitted |
| D06 | Draft deployment guidance from `fixtures/missing-information.md` | Describes only implemented stages; asks about recovery, with unresolved details visible in the draft |
| D07 | Complete an operational guide whose prerequisites are supplied | Uses supplied facts; avoids asking the user to rediscover known information |
| D08 | Draft release notes from `fixtures/release-history.md` | Uses confirmed release boundary; separates pending changes, preserves migration conditions and units |
| D09 | Announce a release when only merge history is supplied | Asks about release identity/state or delivers a labelled draft; invents no deployment or date |
| D10 | Add entries to the changelog in `fixtures/release-history.md` | Retains historical entries and format; pending changes stay Unreleased; related commits are grouped |
| D11 | Write a weekly report from `fixtures/weekly-activity.md` | Keeps period, merge/release distinctions, supplied blocker, and actual validation results accurate |
| D12 | Produce a report from commits without blocker or plan notes | Labels repository-only scope; claims neither "no blockers" nor a committed next-week plan |
| D13 | Report on a period crossing timezones with different merge/author dates | Clarifies a meaningful boundary; uses the relevant event rather than silently mixing timestamps |
| D14 | Turn supplied research notes into a report with conflicting sources | Cites supported findings, distinguishes inference, and preserves uncertainty affecting the answer |
| D15 | Request a research report without any findings and a broad topic | Separates substantial investigation from drafting and clarifies scope when it changes the outcome |
| D16 | Draft the proposal in `fixtures/missing-information.md` | Questions material decisions; labels suggestions; invents no owner, estimate, deadline, or approval |
| D17 | Answer an initial clarification round, leaving one material gap | Carries answers forward, removes resolved markers, keeps the remaining gap visible, asks only necessary follow-ups |
| D18 | Ask for a draft while leaving questions unanswered | Delivers useful evidenced sections with Draft status and visible questions; silence grants no decision |
| D19 | Give an Indonesian request for a new doc beside English docs | Uses surrounding English document convention; chat follows Indonesian unless explicitly overridden |
| D20 | Ask in English to edit an Indonesian guide, then request translation | First edit preserves source language; explicit translation changes language without changing technical literals |
| D21 | Document a short linear process and a complex branching flow | Uses simple text for the first and a useful supported diagram for the second; essential steps remain visible |
| D22 | Review broken relative links, an untested command, and a diagram | Reports actual link/command/diagram checks separately from suggested or unavailable verification |
| D23 | Ask for SKILL.md authoring, generated API references, or a wording-only cleanup | Recognizes the scope boundary instead of forcing a documentation workflow |

Use `rubric.md` for review. Cases describe decisions and meaning, not a required exact wording or heading sequence.

## Structure and Readability Coverage

| ID | Request and Evidence | Observable Success |
|---|---|---|
| D33 | Write an API spec from `fixtures/api-spec-evidence.md` | Follows the fixed order; Decisions Needed table is near the top; one section per endpoint; no test results inside the document |
| D34 | Write the same spec in Indonesian | Descriptive sentences with a subject; harus/sebaiknya/bisa used consistently; field names stay in English |
| D35 | Mixed content: contract, frontend behavior, backend implementation | Separates audiences into sections or files; does not interleave them |
| D36 | Draft a design doc with two unresolved options | Decisions Needed table first with a labeled recommendation; no approved-status claim |
| D37 | A draft refers to "the current handler" and "the previous plan" | Rewrites with named files or versions; no unnamed context references |
| D38 | Verification finished with 3,156 passing tests | Result appears in the chat reply, not inside the spec or design doc |
