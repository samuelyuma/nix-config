# Library Documentation (Context7)

If a library documentation tool is available (a Context7 MCP server, which finds a library and returns its documentation), use it for claims that depend on a library or framework version. Do not name the tool in the output. Tool names differ between clients: check the tools you actually have. Usually there is one step to find the library ID and one step to fetch documentation for a topic.

## Use It For

- Function signatures, options, config keys, CLI flags.
- Behavior that changed between versions, deprecations, migration steps.
- Whether a feature exists in the version the project uses.
- Correct usage before writing a plan step, an example, or an instruction that depends on the library.

## Do Not Use It For

The repository's own code, general concepts, language features you can confirm by reading the source, or claims you can settle by reading the code in this repo.

## How

1. **Find the version.** Read the lockfile or manifest. Ask for documentation for that version. If only the latest is available and it differs from the project's version, say so and name the difference.
2. **Ask a narrow question.** One topic per call, such as "retry options for the HTTP client". Not "explain library X". Keep the number of calls small.
3. **Do not send secrets or private code.** A query holds only the library name and a technical question.
4. **Treat it as a secondary source.** It indexes documentation from third parties. If it disagrees with official documentation or the library's source in the repo, the official source or the code wins. Record the conflict.
5. **Cite precisely.** Name the library, version, and documentation section. Do not call a code sample tested unless it was run.
6. **Fall back in order.** If the tool is missing or finds nothing: fetch the library's official documentation page; then read the installed source; then say the claim is unverified. Never answer from memory as if it were checked.

## Output

State what the documentation says, which version it applies to, and anything not confirmed. If a plan, spec, or instruction depends on the claim, mark it verified or unverified.
