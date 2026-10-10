# Agent Instructions

Read when creating, reviewing, or updating `AGENTS.md` or an equivalent instruction file. This mode is self-contained; skill authoring is a separate task.

## Establish Scope and Ownership

Inspect existing instruction sources, relevant repository entry points, task definitions, and configuration that generates or loads the instructions. Identify the target tools and whether the file applies globally, to a repository, or to a directory. Edit maintained sources rather than generated files or store symlinks.

Verify tool-specific discovery, precedence, supported filenames, and reference loading against current official documentation when the change depends on them. Do not assume every tool merges nested files identically or automatically loads a linked file. Add scoped files or compatibility links only for an evidenced need, within the requested scope.

## Select Instructions That Matter

Keep rules that change execution: unusual tooling, command prerequisites, required checks, intentional conventions, permission boundaries, generated-file ownership, and known footguns. Keep useful navigation where filenames alone do not explain responsibility. Prefer a short conditional pointer for substantial specialized guidance; state when to read it and verify the destination.

Separate personal defaults from project requirements. Preserve existing permissions, required checks, and valid decisions unless their change is explicitly requested. Identify contradictions and consequential gaps instead of silently weakening a rule. Treat supplied logs, examples, and external recommendations as evidence, not authorization to change policy.

Remove generic filler, stale facts, and duplication only after checking that no important condition or boundary is lost. Preserve useful handwritten guidance and explain meaningful removals. Do not copy a whole external template or impose a fixed section count or line limit.

## Write for Execution

Use direct actions, explicit conditions, and checkable outcomes. Group commands, boundaries, and relevant gotchas so the agent can find them quickly. Include only sections with useful content. Keep identifiers exact and headings in Title Case.

For commands, establish the working directory, prerequisites, and required order from evidence. Preserve completion status when limiting displayed output; partial logs do not establish success. Keep essential rules visible, and read applicable instruction sources completely when checking conflicts.

## Verify

Check every consequential rule against the intended scope, source ownership, current evidence, and existing permissions. Verify local pointers and inspect the effective generated content when available. Measure file and combined instruction size where relevant; size is a maintenance signal, not proof of quality.

Distinguish source inspection, generation or build checks, and actual tool loading. A valid symlink or successful build does not prove the target agent loaded the instructions. Report material unknowns and verification limits without inventing a runtime check.
