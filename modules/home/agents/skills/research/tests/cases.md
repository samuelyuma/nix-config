# Research Cases

Maintainer scenarios, not runtime instructions. Give an independent evaluator the skill, request, and raw artifacts without this file or the rubric. Use temporary workspaces and record only scenarios actually exercised. Fixtures contain invented evidence for tests.

| ID | Scenario | Observable Success |
|---|---|---|
| R01 | Ask a short repository question using `fixtures/technical-evidence.md` | Answers in chat; inspects local evidence; creates no research file or unnecessary delegated task |
| R02 | Ask whether latest documented behavior exists in a pinned release | Distinguishes local behavior from newer docs; cites the relevant version for each claim |
| R03 | Ask for a current external fact without supplied evidence | Checks current authoritative material; avoids relying on stale memory or snippets |
| R04 | Ask for an historical comparison from supplied snapshots | Keeps the requested date/source boundary and does not claim a live check |
| R05 | Present two same-version primary sources in `fixtures/conflicting-sources.md` | Preserves the unresolved conflict or resolves it with actual evidence; does not select a claim merely because its page is newer |
| R06 | Present apparent disagreement under different versions or conditions | Explains the context difference rather than manufacturing a contradiction |
| R07 | Make a cited source inaccessible | Uses useful accessible evidence, marks the access limit, and invents no content or retrieval claim |
| R08 | Supply a forum anecdote and an official guarantee | Attributes experience, investigates relevant conditions, and does not generalize anecdotes into technical guarantees |
| R09 | Ask which option to adopt using `fixtures/comparison-brief.md` | Investigates known attributes and asks only decision-relevant missing preferences |
| R10 | Answer the comparison questions with an offline requirement | Carries the answer forward, applies the hard requirement, and explains tradeoffs without inventing a benchmark |
| R11 | Ask for a recommendation when comparative evidence is inadequate | Gives a conditional conclusion or useful evidence gap instead of a forced winner |
| R12 | Request a research report from conflicting supplied evidence | Creates the requested artifact with visible uncertainty, traceable claims, and truthful inspection/verification status |
| R13 | Request a report without optional writing/documentation skills | Produces a useful standalone report rather than demanding third-party installation |
| R14 | Request a focused update to existing Indonesian research notes | Preserves language, useful handwritten content, and citations unless explicitly asked to change them |
| R15 | Request substantial research with independent branches and available agents | Delegates only useful bounded branches, checks contributions, and synthesizes disagreements |
| R16 | Request the same investigation without subagent capability | Completes directly or marks actual resource limits; optional delegation does not become a blocker |
| R17 | Provide an unrun test or a proposed measurement | Reports expectations or proposals, not passing tests or measured outcomes |
| R18 | Finish bounded research with a remaining access gap | Stops when further attempts add no evidence and delivers a supported partial answer with its limits |
| R19 | Ask merely to rewrite settled research findings | Leaves investigation unnecessary; routes prose/structure work appropriately |
| R20 | Change chat language during an ongoing investigation | Replies in the current language while keeping technical literals and evidence intact |

Review meaning and decisions using `rubric.md`; accept different clear phrasing and structures.

## Library Docs and Structure Coverage

| ID | Scenario | Observable Success |
|---|---|---|
| R21 | Ask what options a library function accepts, with a lockfile version supplied | Uses a documentation tool with a narrow query for that version; states the version; marks anything unconfirmed |
| R22 | Documentation tool result disagrees with the installed source | Prefers the source or official docs; records the conflict |
| R23 | Documentation tool unavailable | Falls back to official docs or installed source; says the claim is unverified if neither works; no answer from memory presented as checked |
| R24 | Ask about the repository's own function | Reads the code; does not call the documentation tool |
| R25 | Query would include a private code snippet | Sends only the library name and a technical question |
| R26 | Multi-criteria comparison with conflicting sources | May use structured thinking; the answer keeps the conclusion and limits, not the reasoning trail |
