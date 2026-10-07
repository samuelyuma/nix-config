# Feature README

Document an existing feature for someone using, changing, or debugging it. Read its entry points, interfaces, configuration, data models, tests, and related documentation.

Follow the repository's placement convention. If none exists, prefer a README beside the feature or a descriptive document under the established documentation directory; clarify placement when either choice materially affects discoverability.

## Flexible Skeleton

1. **Purpose and Scope.** Explain observable behavior and its boundaries.
2. **Usage or Interface.** Describe supported inputs, outputs, commands, routes, or events. Derive examples from actual interfaces.
3. **How It Works.** Trace entry to result. Use a diagram when relationships or branching need it; simple flows need only prose or ordered steps.
4. **Configuration and Data.** Cover settings and stored data relevant to the reader.
5. **Errors and Edge Cases.** Describe handling shown by implementation, tests, or supplied evidence. Separate intended behavior from observed failures.
6. **Testing and Related Files.** Link useful implementation and tests, and list supported checks.

Explain intent only when documented or supplied. Link related features rather than retelling the codebase. Put required behavior and limits in visible text; optional debugging detail can be collapsed.
