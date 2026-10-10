# API Spec

For endpoint contracts, event streams, and the behavior around them. The reader is a developer who will build or call the API. Read the real handlers, DTOs, routes, and tests first. A spec written from memory is a failure.

## Fixed Order

1. **Summary.** 3 to 5 sentences: what is being built, for whom, and the status (Draft, Proposed, Implemented).
2. **Decisions Needed.** A table: decision, recommendation, reason, effect if undecided. Omit the section only if there is none. Link each row to the section it affects.
3. **Overview.** A table of endpoints (method, path, purpose). Scope and non-goals in a few lines.
4. **Common Rules.** Authentication, authorization, ID and timestamp formats, response envelope, error shape, idempotency, versioning. Write each rule once here. Do not repeat it per endpoint.
5. **One section per endpoint**, always in this shape:
   - Purpose (one sentence)
   - Request: headers, path, query, body table (field, type, rule), one example
   - Response: status codes, body example, field notes
   - Errors: table (status, code, when)
   - Behavior notes: what the server does, step by step, with an explicit actor
6. **Realtime or Events** (if any). Connection, event table (name, when sent, payload, what the client does), resume and reconnect rules.
7. **Client Guide** (optional). What the frontend does: loading order, merging, retries. Keep it separate from the contract.
8. **Implementation Notes** (optional, for backend). Files to change, data changes, risks. Prefer a separate file when long.
9. **Open Questions.**

## Rules for the Content

- A rule has an actor and a strength: "The server must reject...", "The client should retry...", "The client may omit...". Do not write a run of bare imperatives.
- Parallel rules go in a table. Do not bury five conditions in one paragraph.
- One example per request and response is enough. Examples must match the field tables.
- Show only fields that exist or are decided. Mark undecided fields as Proposed.
- Mark status: Implemented, Proposed, or Unknown. Do not describe a proposal as existing behavior.
- Do not put test results, command output, or inspection logs in the spec. Put them in the reply.
- Do not refer to "the current" or "the previous" thing without naming it (file or version).

## Split Guidance

Split into separate files when the document passes roughly 400 lines or serves two audiences:
- `api-contract.md`: sections 1 to 6 (frontend and backend share it)
- `client-guide.md`: frontend behavior
- `implementation.md`: backend work, data changes, rollout

## Indonesian Output

Write the descriptive parts with a subject ("Server mengirim..."), keep field names, status codes, and protocol terms in English, and use harus / sebaiknya / bisa consistently. Read `writing/references/languages/indonesian.md`.
