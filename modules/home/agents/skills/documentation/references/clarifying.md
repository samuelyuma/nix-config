# Clarifying Missing Information

Use this built-in interview when missing facts, conflicting evidence, or unclear decisions materially affect the document. It does not require a grilling or domain-modeling skill.

## Before Asking

Read available evidence first. Separate facts you can investigate from decisions only the user can make. Ask about audience, boundaries, placement, release state, or intent only when the answer changes the result. Handle isolated edits and sufficiently evidenced documents directly.

## Focused Rounds

1. Group independent questions into a small round. Name the gap, explain its consequence, and offer choices only when they help. Label your recommendation and give its reason.
2. Keep dependent questions for the next round. Avoid asking the user to inspect code or repeat answers already given.
3. Track verified facts, confirmed user decisions, and unresolved questions. Carry answers forward and update the working draft as they arrive.
4. Continue until the material gaps are resolved or the user asks to proceed with a draft. Work on independent, evidenced sections while waiting; silence does not confirm an assumption or recommendation.

Resolve conflicts explicitly: identify the differing sources and their dates or contexts, investigate what can be checked, and ask for a decision only when needed. A declared target can differ from current implementation; label both rather than treating the target as existing behavior.

## Unanswered Questions

Keep important unresolved information visible near the affected section or in an Open Questions section. Use a clear status such as Unknown, Needs Confirmation, or Proposed. Avoid hidden HTML TODOs for information readers need to assess accuracy.

```markdown
## Open Questions

- Needs Confirmation: Does rollback also restore the previous database schema?
- Unknown: No release date was supplied.
- Proposed: Publish the guide under docs/workflows/; placement is unconfirmed.
```

Label the document Draft when unresolved questions affect its correctness or usability. An optional unsupported claim can be omitted instead. Remove resolved markers after incorporating the answer; preserve remaining questions in delivery. Ask again only when new information changes the decision or the previous answer remains materially ambiguous.
