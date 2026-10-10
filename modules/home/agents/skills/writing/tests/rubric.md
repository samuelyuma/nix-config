# Evaluation Rubric

Score each applicable criterion as pass or fail. Record the output and the evidence for each failure. This is a qualitative review, not word matching.

| Criterion | Pass Condition |
|---|---|
| Meaning | Required claims, qualifications, negations, numbers, units, and relationships survive |
| Grounding | No invented fact, cause, command, source, metric, completed action, or successful check |
| Clarity | The main point is easy to find; grammar and step order have one clear reading |
| Actor Clarity | Every rule says who acts (server, frontend, reader). No string of subjectless commands for system behavior |
| Modal Consistency | Required, recommended, and optional are distinguishable (harus / sebaiknya / bisa, or must / should / may) |
| Anti-slop | Empty emphasis, vague authority, filler, repetition, and decorative formatting are removed |
| Voice | Clear source text and intentional author habits are preserved; no mechanical blacklist |
| Depth | Enough information for the request, with no arbitrary length cap and no padding |
| Language | Requested language wins; follows the current message; edits keep the source language; term policy is applied (protocol terms stay, ordinary words are translated) |
| Self-Contained | No reference to context the reader lacks ("yang sekarang", "plan sebelumnya") without a name |
| Literal Integrity | Code, identifiers, paths, errors, quotations, links, and technical terms stay exact |
| Use Case | Output fits chat, document, PR, commit, or comment conventions |
| Scope | Drafting prose causes no unrelated edits, commits, publication, research, or implementation changes |

## Acceptance

Every executed case must pass Meaning, Grounding, Literal Integrity, and Scope. A failure there blocks acceptance even if the text sounds more natural. Language-switching cases must pass every turn. Other applicable criteria must pass before accepting a revised skill.

Compare against the previous skill snapshot for regressions. A rewrite that is shorter but loses subjects or connectors is a regression.

Keep real evaluation outputs outside the deployed skill so routine writing does not load them.
