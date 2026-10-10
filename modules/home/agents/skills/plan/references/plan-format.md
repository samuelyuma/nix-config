# Plan Format

Use this minimal shape. Drop a section only when it truly does not apply. A small change can be a few lines under Goal and Steps.

1. **Goal.** The behavior to achieve and how you will know it works. Two or three sentences.
2. **Decisions Needed.** Table: decision, options, recommendation, effect on steps. Omit if there is none. Unanswered questions stay here, not scattered in steps.
3. **Scope.** What changes and what does not.
4. **Steps.** Numbered. Each step has:
   - the change and the affected files or modules (mark new files),
   - dependencies, when it is not just "the step before",
   - a completion check someone can observe.
   Mark steps that wait on a decision as "Blocked by D1".
5. **Verification.** Acceptance criteria tied to the requested behavior, the project checks to run (from the repo's instructions), and any new tests to add.
6. **Risks and Unknowns.** Only those that can change the plan.

## Rules

- Steps are in dependency order. Independent work can be marked as parallel.
- Use stable step labels (S1, S2) when the plan will be updated or handed off.
- Do not include inspection logs or past check results. Say them in chat.
- Separate "ready to implement" from "needs investigation" from "blocked".
- If the plan is long or has several audiences, split it: a short plan here, contracts or design in a document.
