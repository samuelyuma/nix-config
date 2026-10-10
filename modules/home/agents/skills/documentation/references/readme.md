# README (Project or Feature)

Help a reader understand what this is and complete the first useful action. Read entry points, manifests, task definitions, safe config schemas, tests, and existing docs first.

Follow the repository's placement convention. If there is none, put a project README at the root, and a feature README beside the feature or under the established docs directory.

## Project README

1. **Name and Purpose.** What it does and for whom, within what the code supports.
2. **Quick Start.** Prerequisites, then install and run, using the real package manager, lockfile, and task runner. Separate local development from production.
3. **Usage.** The main supported action with an example derived from the real interface.
4. **Configuration.** Setting names, purposes, defaults, and requirements from safe schemas. Never show real credentials.
5. **Development.** Supported checks and contribution links.
6. **Structure.** Only when readers need help navigating. Link deeper docs instead of copying them.
7. **License.** Link an existing file. A missing license is a question, not a choice for you to make.

Keep the first screen useful. In focused updates, keep the existing section order. Badges need a verifiable source.

## Feature README

1. **Purpose and Scope.** Observable behavior and its boundaries.
2. **Usage or Interface.** Inputs, outputs, commands, routes, or events, with examples from real interfaces.
3. **How It Works.** Entry to result. A diagram only when branching or relationships need it.
4. **Configuration and Data.** Settings and stored data the reader needs.
5. **Errors and Edge Cases.** Handling shown by code, tests, or supplied evidence. Separate intended behavior from observed failures.
6. **Testing and Related Files.** Useful links and supported checks.

Explain design intent only when it is documented or supplied. Put required behavior and limits in visible text. Optional debugging detail can be collapsed.
