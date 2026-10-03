# Workflow README

Documents a process: deployment, release, CI/CD, an operational procedure, or an application flow such as a request or data flow. Audience: someone who must run, debug, or change the process.

## Where It Goes

Follow the repo's convention, for example `docs/deployment.md` or `docs/workflows/<name>.md`. If none exists, prefer `docs/<name>.md` and link it from the root README.

## Read First

- Pipeline files: `.github/workflows/*`, `Dockerfile`, compose files, deploy scripts, release scripts.
- Everything those files call: scripts, task runner targets, remote commands.
- Environment and secret names they reference.
- For an application flow: the entry points, handlers, queues, and services involved.

## Skeleton

Include a section only if there is grounded content for it.

1. **Purpose and Trigger.** What the process does and when it runs (push, tag, manual dispatch, schedule). Read from the `on:` block or the entry point.
2. **Overview Diagram.** A Mermaid flowchart or sequence diagram of the real stages, using the real job and service names.
3. **Stages.** A table: stage or job, what it does, where it is defined (file path).
4. **Environments.** A table of targets (for example staging and production), with how each is selected.
5. **Required Secrets and Variables.** A table of names and purposes. Never values.
6. **Running It Manually.** The exact commands or dispatch steps, if they exist.
7. **Failure Handling and Rollback.** Only what the files implement. If nothing is implemented, say that plainly or leave a TODO. Do not describe a rollback that does not exist.
8. **Troubleshooting.** Only problems evidenced by the repo or provided by the user. Put long sections in a collapsible block.
9. **Decisions.** The reason behind design choices goes here only if it is written in the repo or the user supplied it. Otherwise leave a TODO. Do not invent rationale.

## Notes

- A destructive or order-sensitive step deserves an alert, for example "migrate before deploying the new version".
- One diagram per flow. A deployment pipeline and a rollback path are two flows only if both exist in the files.
- Reflect the pipeline as it is, even if it looks incomplete. Gaps become TODOs, not silent improvements.
