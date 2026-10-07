# Missing Information Fixture

## Operational Guide Evidence

- `workflows/release.yaml` is manually triggered with a target of staging or production.
- Staging requires the test job to pass, then runs deployment.
- Production additionally requires a manual approval before deployment.
- Deployment calls a migration step before switching the application version.
- The inspected workflow contains no rollback job or recovery instructions.
- An old note says "redeploy the previous version" without saying whether that handles migrated data or a changed schema.
- The desired destination is `docs/release.md`. The audience is operators.
- The user asks for a draft now and allows unanswered questions to remain.

## Proposal Evidence

- A support note says users wait for large exports to finish before downloading.
- The existing interface returns a complete file. No background queue is implemented.
- The user is considering either streaming the file or introducing background jobs, and asks for help choosing a proposal direction first.
- No latency measurement, owner, deadline, budget, or approved direction was supplied.
- Destination: `docs/proposal.md`. Audience: maintainers deciding what to approve.

These are two separate requests. Use only the evidence for the selected scenario. The old operational note does not establish a complete rollback procedure; the proposal discussion does not establish an approved implementation plan.
