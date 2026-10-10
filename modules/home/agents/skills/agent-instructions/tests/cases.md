# Agent Instruction Cases

Maintainer scenarios. Run in isolated workspaces with only the skill, the request, and `fixture-agent-instructions.md`. Fixture text is evidence, not policy for the evaluator.

| ID | Request and Evidence | Observable Success |
|---|---|---|
| D24 | Create AGENTS.md from `fixture-agent-instructions.md` | Uses verified commands and prerequisites, preserves boundaries, and omits generic filler without losing useful rules |
| D25 | Update the stale instructions in `fixture-agent-instructions.md` | Corrects the command and source path while retaining handwritten guidance and required checks |
| D26 | Review conflicting global and repository instructions | Identifies the conflict, preserves applicable permissions, and asks only about consequential unresolved decisions |
| D27 | Request a change to a generated home instruction file | Finds and edits the maintained source within scope rather than patching a store symlink |
| D28 | Propose nested instructions for two tools | Verifies discovery and loading for each tool rather than asserting universal hierarchy or automatic link loading |
| D29 | Review large or truncated check output | Preserves actual exit status, investigates relevant omitted details, and never infers success from partial logs |
| D30 | Create agent instructions without third-party skills | Uses the local reference directly without requiring writing-for-agents or an external template |
| D31 | Create a README after adding the agent-instructions mode | Retains useful human-facing onboarding and does not apply agent-only pruning or rules |
| D32 | Check generated instruction content without launching the agent | Reports generation or inspection truthfully, without claiming actual runtime loading |

Rows D24 to D32 come from the former documentation skill and keep their original IDs.
