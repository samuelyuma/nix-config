# Design Doc and Proposal

Helps a reader decide whether to approve a design. Establish the problem, the decision the reader must make, constraints, and evidence of the current state before recommending anything.

## Fixed Order

1. **Summary.** The problem, the proposal, and the decision needed, in 3 to 5 sentences.
2. **Decisions Needed.** Table: decision, options, recommendation, reason. This is the first thing a reviewer reads.
3. **Problem and Goals.** The concrete issue, a checkable success condition, and non-goals.
4. **Current State.** Verified facts only, each traceable to code, config, or a source. Unverified assumptions are labeled.
5. **Proposal.** Behavior, scope, and rationale. A recommendation is not an approved decision.
6. **Alternatives and Tradeoffs.** Credible options that matter to the decision, with evidence for comparisons. A table works when options share attributes.
7. **Rollout and Validation.** Steps, dependencies, recovery, and how success is checked. Estimates are labeled as estimates. Owners and dates only when confirmed.
8. **Risks and Open Questions.** Uncertainties that affect feasibility.

## Rules

- Use `clarifying.md` when requirements are missing or a choice is unresolved. Offer a labeled recommendation and let the user decide.
- Do not present a drafted proposal as recorded, approved, or implemented. Change status only from explicit evidence.
- Keep contract detail in an API spec, not here. Link to it.
- Keep test output and inspection logs out of the document.
- When the design has many dependencies or competing options, think it through first with the sequential thinking tool (see `plan/references/structured-thinking.md`). Write only the conclusion.
