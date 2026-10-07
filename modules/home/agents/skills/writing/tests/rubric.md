# Evaluation Rubric

Score each applicable criterion as pass or fail. Record the output and the evidence for each failure; this is a qualitative evaluation, not a word-matching test.

| Criterion | Pass Condition |
|---|---|
| Meaning | Required claims, qualifications, negations, numbers, units, and relationships survive |
| Grounding | No invented fact, cause, command, source, metric, completed action, or successful check |
| Clarity | The main point is easy to find; grammar and step order have one clear reading |
| Anti-slop | Empty emphasis, vague authority, filler, repetition, and decorative formatting are removed |
| Voice | Clear source text and intentional author habits are preserved; no mechanical blacklist |
| Depth | Enough information for the request, without an arbitrary length cap or unnecessary expansion |
| Language | Requested language wins; conversation switches follow the current message; edits retain source language |
| Literal Integrity | Protected code, identifiers, paths, errors, quotations, links, and technical terms remain exact |
| Use Case | Output fits chat, documents, PRs, commits, or comments and preserves existing conventions |
| Scope | Drafting prose does not cause unrelated edits, commits, publication, research, or implementation changes |

## Acceptance

Every executed case must pass its required meaning, grounding, literal-integrity, and scope checks. A failure in those criteria blocks acceptance even if the result is shorter or sounds more natural. Language-switching cases must pass every turn.

Other applicable criteria must pass before accepting a revised skill. Record improvement, equivalence, or regression against the old skill; an already-good old output need not become different to pass. Existing formatting bans intentionally become contextual guidance where the user approved that change.

Fix the demonstrated failure rather than adding a rule for every unusual word. Rerun affected cases and any cases sharing the changed rule. Keep actual evaluation outputs outside the deployed skill so routine writing does not load them.
