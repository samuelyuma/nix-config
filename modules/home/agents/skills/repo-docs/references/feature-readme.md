# Feature README

Documents an existing feature of the codebase. Audience: a developer who must use, change, or debug that feature.

## Where It Goes

Follow the repo's convention. Look for existing feature docs first: a `README.md` inside the feature directory, or a file under `docs/`. If there is no convention, put `README.md` in the feature's own directory.

## Skeleton

Include a section only if there is grounded content for it.

1. **Name and Purpose.** One or two sentences, inferred from what the code does and nothing more.
2. **Where It Lives.** The paths of the main files and directories.
3. **How It Works.** The flow from entry point to result. Use a Mermaid sequence diagram when the flow crosses 3 or more components, such as handler, service, and repository. Otherwise use a short numbered list.
4. **Interface.** A table of what it exposes: endpoints, functions, commands, or events, with inputs and outputs. Read these from route definitions, schemas, or signatures.
5. **Configuration.** Env vars or settings that change its behavior, as a table.
6. **Data.** Tables, models, or schemas it reads or writes.
7. **Errors and Edge Cases.** What the code explicitly handles. Put long lists in a collapsible section.
8. **Testing.** Where its tests are and the command that runs them.
9. **Related.** Links to other docs or features it depends on.

## Notes

- Document behavior the code and tests show. If intent is unclear, add a TODO instead of guessing.
- Do not restate the whole codebase. Link to files with relative paths.
