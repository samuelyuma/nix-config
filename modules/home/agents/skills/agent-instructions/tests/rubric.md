# Agent Instructions Rubric

| Criterion | Pass Condition |
|---|---|
| Scope | Matches global, project, or directory scope; edits the maintained source, not a generated file |
| Grounding | Every command and prerequisite comes from the repo or supplied evidence |
| Preservation | Required checks, permissions, and useful handwritten rules survive; meaningful removals are explained |
| Signal | No generic filler; each rule changes agent behavior |
| Conflicts | Contradictions are reported, not silently resolved |
| Verification | Source inspection, generation checks, and runtime loading are reported separately; no claim of loading without a run |

Fail invented commands, weakened permissions, treating partial logs as success, and claiming runtime loading without evidence.
