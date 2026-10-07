# Technical Research

## Repository Evidence

Establish the relevant repository, feature, environment, and installed or pinned version. Read the smallest useful path through implementation, configuration, callers, tests, and existing documentation. Trace a workflow through its called scripts rather than inferring behavior from a filename or stack convention.

Use source links readers can inspect. Separate implemented behavior, test expectations, documented intent, and runtime observations. An unrun test shows an expectation, not a passing result. Missing behavior in the inspected files does not prove that no other implementation exists.

Read safe configuration schemas and names; never inspect secret values. Use existing task definitions or help to establish commands. Run only safe, relevant checks within the authorized scope. Keep experiments isolated when needed and report what they actually establish.

## Outside Sources

Check official documentation, source, specifications, or release notes for the relevant version and platform. Use required documentation connectors when available. The latest documentation can describe behavior absent from the repository's pinned version; show the difference explicitly.

Use `sources.md` for external evidence and conflicts. Forum reports can reveal a failure to investigate, but do not establish a general API guarantee. Inspect the original report's conditions and follow its primary references.

Give compatible examples only when supported by inspected interfaces. Separate proposed changes from current support. If a public specification and implementation differ, identify which claim concerns intended behavior and which concerns observed behavior; avoid silently choosing one as universally true.
