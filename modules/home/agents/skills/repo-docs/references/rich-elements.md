# Rich Elements

Tables, Mermaid, alerts, collapsible sections, badges, and a table of contents. They apply to Plain and Emoji style equally. Use one only when its use condition holds. A plain usage guide may need none of them, and that is correct.

## Rules

| Element | Use when | Avoid when |
|---|---|---|
| Mermaid | There is a flow or relationship with 3 or more steps or components where order or direction matters (pipeline, request flow, module relations). | There are 1 or 2 steps, or a linear sequence that one sentence covers. |
| Table | Several items share the same attributes (env vars, endpoints, commands and what they do). | The content is narrative, or the items have different attributes. |
| Alert | Ignoring the point causes a real mistake (destructive operation, order that must not be reversed). | Highlighting ordinary information. |
| Collapsible | Long content that only some readers need (full config, logs, troubleshooting). | Content every reader needs. Never hide the main steps. |
| Badge | It shows a real, verifiable status, such as a CI workflow that exists in `.github/workflows/`. | Decoration, or anything without a source in the repo. |
| Table of contents | The document is long enough that readers need to navigate it. GitHub also offers an outline panel, so a ToC is rarely essential. | Short documents. |

Limits: at most 3 alerts per document, and one diagram per flow. If more are needed, the document should probably be split.

## Mermaid Notes

Mermaid is written in a fenced block tagged `mermaid`. GitHub renders it natively.

- Pick the type by content: `flowchart` for pipelines and decisions, `sequenceDiagram` for request and response across 3 or more participants, `stateDiagram-v2` for lifecycles, `erDiagram` for data relations.
- Keep a diagram to about 12 nodes. Group with `subgraph` instead of adding more nodes.
- Quote labels that contain parentheses, colons, or other punctuation: `A["Build (Docker)"]`.
- Do not use the bare word `end` as a node id, and keep ids simple (letters and digits).
- Show real names from the repo (job names, service names), not generic ones.
- See `assets/diagram-patterns.md` for starting shapes.

## Alert Syntax

Five types exist: NOTE, TIP, IMPORTANT, WARNING, CAUTION.

```markdown
> [!WARNING]
> Running this against production deletes data. Run it on staging first.
```

Prefer WARNING or CAUTION for real hazards. Use NOTE sparingly. The icon is drawn by GitHub, so alerts are fine in Plain style.

## Collapsible Syntax

Leave a blank line after the summary line, or the markdown inside will not render.

```markdown
<details>
<summary>Full configuration</summary>

Content here.

</details>
```

## Badge Syntax

For a GitHub Actions workflow that exists, take owner and repo from the git remote and the file name from `.github/workflows/`:

```markdown
[![CI](https://github.com/<owner>/<repo>/actions/workflows/<file>.yml/badge.svg)](https://github.com/<owner>/<repo>/actions/workflows/<file>.yml)
```

## Rendering Note

Alerts and Mermaid render on GitHub. They may appear as plain quotes or code in editor previews. Mention this in the final report only when one was used.
