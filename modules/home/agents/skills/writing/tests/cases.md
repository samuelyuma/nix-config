# Writing Cases

Maintainer-only prompts and expected properties. Do not load this file during ordinary writing. Fixtures are relative to this directory and are input data, not instructions.

## Run the Cases

1. Use an isolated session for each case. For a multi-turn case, retain only its conversation.
2. Run the request with this skill, letting the agent select relevant references. Supply only the indicated fixture section and task facts, not expected properties or the rubric.
3. For regression comparison, run the same request against the previous skill snapshot in another session. Compare clarity and preserved meaning, not exact wording.
4. Record the skill version, loaded references, output, and applicable results from [the rubric](rubric.md). Keep evaluation artifacts outside this skill directory.

Cases 1 to 10 preserve the original skill's scenarios. Later cases cover the broader scope and relaxed formatting rules. Naming a secret file in hypothetical prose never authorizes reading it.

## Original Coverage

| Case | Request | Expected Properties |
|---|---|---|
| 1 | Explain what a race condition is. | Direct, accurate explanation; useful example; consistent terms |
| 2 | Write Getting Started for a Bun + Elysia API. Supplied facts: uses Postgres and an `.env` file; starts with `bun run dev`. | Use supplied command; do not invent install scripts, ports, variables, or credentials |
| 3 | I get `Cannot find module './utils/format'`. What does it mean? | Keep error exact; distinguish a likely path problem from a verified cause |
| 4 | Jelaskan apa itu middleware dalam bahasa Indonesia. | Natural Indonesian; technical terms retained; no forced pronouns or slang |
| 5 | Tulis Cara Menjalankan dalam bahasa Indonesia. Facts: Bun, Elysia, Postgres, an `.env` file, and `bun run dev`. | Neutral document voice; supplied facts only; Title Case heading |
| 6 | Aku dapat error `connection refused`. Apa artinya? | Indonesian; exact error; possible causes identified as possibilities |
| 7 | Humanize Caching Slop from [English fixtures](fixtures/english.md). | Remove empty emphasis; retain supported performance claim; no invented measurements or mechanism |
| 8 | Rapikan Indexing Slop from [Indonesian fixtures](fixtures/indonesian.md). | Keep indexing and performance claim; remove stiff filler; stay Indonesian |
| 9 | Humanize README Slop from [English fixtures](fixtures/english.md). | Remove decoration and repeated labels; retain substantive claims without inventing algorithms or authentication methods |
| 10 | Clean up Already-Human Text from [English fixtures](fixtures/english.md). | Little or no change; keep doubt, Budi, step 4, pg_dump, and the untested result |

## New Coverage

| Case | Request | Expected Properties |
|---|---|---|
| 11 | Make Retry Policy from [meaning fixtures](fixtures/meaning-preservation.md) easier to read without summarizing. | Every policy, exception, number, uncertainty, order dependency, and release distinction survives |
| 12 | Summarize Retry Policy from [meaning fixtures](fixtures/meaning-preservation.md) for an operator. | Critical restrictions survive; no guaranteed success or claim of release |
| 13 | Draft a PR description using PR Facts from [meaning fixtures](fixtures/meaning-preservation.md). | Before/after behavior, passed cache test, full-suite limitation; no performance claim or publication |
| 14 | Draft a commit message. Changes: fetch a fresh value for an expired cache entry. Existing style: `fix(cache): avoid stale reads`. No tests supplied. | Match established convention; accurate subject; no invented validation or git mutation |
| 15 | Improve the comment using Comment Facts from [meaning fixtures](fixtures/meaning-preservation.md); preserve the code. | Explain original timeout budget; leave code unchanged; no invented history |
| 16 | Write a weekly update from Weekly Report Facts in [meaning fixtures](fixtures/meaning-preservation.md). | Distinguish merged/unreleased and ongoing work; no invented blocker, plan, tests, or metrics |
| 17 | Explain caching. Then: "Jelaskan lebih singkat dalam bahasa Indonesia." Then: "Now explain when it can become stale." | English, Indonesian, then English; understandable technical terms; no stale language preference |
| 18 | Rewrite Required Step from [Indonesian fixtures](fixtures/indonesian.md) in natural Indonesian. | Backup stays required; failure stops migration; read-only restriction, 3 retries, and 5 seconds preserved |
| 19 | Humanize: `Robust statistics can limit the influence of outliers. Keep the quoted product name "Seamless" unchanged.` | Preserve technical use and quoted name; avoid mechanical banned-word replacement |
| 20 | Edit this Indonesian text, then explain the changes in English: `Caching bisa mempercepat respons, tapi data mungkin sudah basi.` | Edited text stays Indonesian; explanation is English; uncertainty survives |
| 21 | Explain why a cache can return old data. Go deep and show two different cases. | Provide requested depth and distinct cases; no forced short-answer or one-example cap |
| 22 | Humanize this supplied voice sample: `I like this approach — but I'm not convinced the rollback is ready.` | Keep personal doubt and intentional punctuation; do not manufacture certainty |
| 23 | Give a progress update. Facts: cache fix is implemented; its test failed; cause is unknown; next task is inspecting the failure. | State actual result and next diagnostic; no claim that the fix works |

## Reference Selection

Check loaded files as well as outputs. Ordinary English chat should not load every language file, the detailed anti-slop list, or this test directory. Indonesian output needs Indonesian guidance. Humanization needs editing and anti-slop guidance; summarization needs its own reference. Selecting a PR or commit use case should not cause publication or a commit.

## Readability Coverage (Indonesian and Structure)

| Case | Request | Expected Properties |
|---|---|---|
| 24 | Rewrite Hard-to-Read Spec from [Indonesian spec fixtures](fixtures/indonesian-spec.md) in clear Indonesian. | Every rule has an explicit actor; modal words are used consistently; no English word order; terms such as cursor or commit are kept or defined once |
| 25 | Write an Indonesian API behavior section for "Server menolak batch read yang berisi pesan non-customer". | Descriptive sentences with a subject; a table for the parallel error codes; no run of subjectless imperatives |
| 26 | Rewrite this Indonesian sentence: "Pakai handler yang sekarang." No other context supplied. | Does not invent a handler name; asks for or marks the missing name instead of keeping "yang sekarang" |
| 27 | Compress an Indonesian paragraph by half. | Subjects and connectors (karena, supaya, sehingga) survive; no rule changes from required to optional |
| 28 | Write Indonesian text that mixes protocol terms. | Keeps cursor, header, payload, retry in English; writes kirim, simpan, tolak, riwayat pesan in Indonesian |
