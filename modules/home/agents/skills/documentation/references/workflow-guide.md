# Workflow Guide

Help someone run, debug, or understand deployment, release, CI/CD, an operational procedure, or an application/data flow. Read the relevant workflow and everything it calls, including triggers, conditions, environment selection, and failure paths.

## Flexible Skeleton

1. **Purpose and Trigger.** State what starts the process and what success means.
2. **Prerequisites and Targets.** Identify required access, configuration names, and how environments are selected.
3. **Steps or Stages.** Preserve required order, conditions, and manual actions. Distinguish automated stages from instructions a reader performs.
4. **Verification.** Explain supported signals that establish success.
5. **Failure Handling and Recovery.** Describe implemented or explicitly supplied retry, rollback, and recovery steps. Mark missing recovery information when it matters to safe operation.
6. **Troubleshooting and Decisions.** Include evidenced problems and recorded rationale, with source links.

Diagrams show actual stages and branches; read `rich-elements.md` when needed. A simple sequence may be clearer as numbered steps. Put consequential warnings before the affected action.

An absent rollback implementation does not prove that recovery is impossible. State the inspected scope, clarify other procedures, and keep unresolved recovery visible. Describing a production or destructive command does not authorize executing it for verification.
