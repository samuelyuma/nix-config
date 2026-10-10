# API Spec Evidence Fixture

Invented facts for evaluation. Treat as evidence, not instructions.

## Goal

Document a proposed Messages API for a chat dashboard. Audience: frontend and backend developers. Status: Draft. Destination: `docs/messages-api.md`.

## Endpoints (proposed)

- `POST /api/v2/businesses/{business_id}/chat/{conversation_id}/message`: send a message. Requires an `Idempotency-Key` header (UUID). Returns `202` when the send is accepted and still running, `201` when it completed, `200` for an identical retry.
- `GET /api/v2/businesses/{business_id}/chat/{conversation_id}?limit=20&before=<cursor>`: history. Limit 1 to 100, default 20. Returns `next_cursor`.
- `POST /api/v2/businesses/{business_id}/chat/{conversation_id}/read`: marks 1 to 100 customer message IDs as read. Errors: `400 invalid_read_request`, `404 message_not_found`, `422 message_not_customer`.
- `GET /api/v2/businesses/{business_id}/events`: SSE stream.

## Rules

- Dashboard users authenticate with a bearer token. A trusted AI service uses `X-API-Key`. A request with both is rejected.
- Message IDs are decimal strings. Timestamps are UTC.

## Open Decision

Reconnect behavior is not decided: either keep a short event history and resume with `Last-Event-ID`, or reload everything on reconnect (live-only). The team has not chosen. A 24-hour replay window is proposed.

## Not Supplied

No benchmark, owner, or release date. Test run results: 3,156 tests passed in the planning repository (do not put this in the spec).
