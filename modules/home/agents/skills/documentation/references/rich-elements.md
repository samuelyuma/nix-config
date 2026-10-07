# Rich Elements

Use formatting to reduce reading effort. A short guide can need none of these elements. Match the destination renderer; use plain Markdown alternatives where support is uncertain.

| Element | Use When | Keep Visible |
|---|---|---|
| Table | Items share attributes or options need comparison | Required conditions and limits |
| Mermaid | Branching, ordering, or relationships are hard to explain in prose | Essential instructions and caveats |
| Alert | Missing the point risks a consequential mistake | Warning before the affected action |
| Collapsible | Long debugging detail or examples are optional | Prerequisites, main steps, breaking changes |
| Badge | A real status has a verifiable source | Explanation if the status is consequential |
| Contents List | Readers need navigation through a long document | Clear headings |

Keep each element purposeful; avoid repeating the same information in prose, table, and diagram. Several hazards can warrant several warnings; document length alone does not determine a fixed count.

## Mermaid

Use a fenced `mermaid` block. Choose flowchart for stages and branches, sequenceDiagram for interactions, stateDiagram-v2 for lifecycles, and erDiagram for data relationships. Use names and edges grounded in evidence, with simple IDs and quoted labels containing punctuation. Avoid the bare word `end` as a node ID. Split or group a diagram when it becomes hard to read.

For starting shapes, inspect `../assets/diagram-patterns.md` only when useful. Its examples are syntax templates, not evidence about the project. Adapt only supported nodes and relationships.

## Alerts and Collapsibles

GitHub-style alerts use a blockquote with a supported type, such as WARNING or CAUTION:

```markdown
> [!WARNING]
> Confirm the target before running the destructive operation.
```

Collapsibles need blank lines around their Markdown body:

```markdown
<details>
<summary>Optional Troubleshooting Detail</summary>

Supporting detail here.

</details>
```

Check the actual renderer when practical. If rendering was not checked, report that limit when these elements affect usability; do not claim GitHub support establishes compatibility with every preview.
