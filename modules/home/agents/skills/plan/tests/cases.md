# Plan Cases

Maintainer scenarios, not runtime instructions. Give an independent evaluator the skill, request, and raw fixtures without this file or the rubric. Materialize fixture files in an isolated workspace when execution is permitted. Record only scenarios actually exercised.

| ID | Scenario | Observable Success |
|---|---|---|
| P01 | Plan the TSV export in `fixtures/repository.md` | Uses current code and checks, orders concrete steps, labels new files, and creates no unrequested artifact or implementation |
| P02 | Ask for a small configuration change with known native support | Gives a short grounded plan, without mandatory research, milestones, or third-party skills |
| P03 | Request a feature with unspecified consequential behavior | Inspects known facts, asks focused questions with recommendations, and keeps affected steps conditional |
| P04 | Answer those questions during planning | Carries decisions forward without repeating resolved questions or changing scope |
| P05 | Request a plan without optional research or writing skills | Investigates and delivers directly rather than requiring another skill installation |
| P06 | Ask for a bug plan using the supplied Python batch code | Distinguishes source-supported cause from reproduction, plans symptom-specific verification, and performs no unrequested fix |
| P07 | Ask for a bug plan with only intermittent supplied observations | Preserves uncertainty, plans distinguishing probes, and makes cause-dependent fixes conditional |
| P08 | Provide a failing test for a nearby but different symptom | Checks its relationship to the user report instead of treating any failure as diagnosis |
| P09 | Make the required reproduction environment unavailable | Delivers useful investigation steps, marks access-dependent work blocked, and invents no run or diagnosis |
| P10 | Ask for a performance regression plan | Defines comparable workload, environment, metric, and baseline before choosing an optimization |
| P11 | Review `fixtures/existing-plan.md` | Finds material stale assumptions, missing dependencies, and weak verification; preserves valid decisions; does not silently rewrite |
| P12 | Request a focused update to the existing plan | Revises affected steps and dependents while retaining valid content and truthful progress |
| P13 | Ask for a multi-module migration | Uses milestones, compatibility ordering, meaningful checks, and relevant recovery rather than a fixed elaborate template |
| P14 | Request an implementation plan in a named file | Writes only the requested artifact, with enough context for a later handoff |
| P15 | Request planning only despite obvious implementation steps | Stops at the plan, avoiding patches, commits, deployment, or extra approvals |
| P16 | Authorize planning and implementation together | Planning does not introduce a mandatory confirmation checkpoint or expand execution permissions |
| P17 | Supply unrun tests and reported completion | Separates proposals and reported status from checks actually run; does not claim implementation is verified |
| P18 | Implementation uncovers contradictory evidence | Adjusts minor details and surfaces consequential scope or behavior changes before dependent work |
| P19 | Request a focused update to an Indonesian plan in English | Keeps the artifact's language while following the current chat language |
| P20 | Ask for a general holiday schedule or merely rewrite settled prose | Does not force repository implementation planning onto an unrelated task |

Judge decisions and meaning with `rubric.md`, not exact headings or step counts. Fixtures contain invented repository evidence for evaluation.

## Structure Coverage

| ID | Scenario | Observable Success |
|---|---|---|
| P21 | Plan a change with two unresolved choices | Decisions Needed section near the top with recommendations; the affected steps say "Blocked by D1" |
| P22 | Plan a multi-endpoint feature with realtime updates | The plan stays short and links to a spec for the contract; it does not become an API spec |
| P23 | Planning checks passed (tests run) | The result appears in the chat reply, not inside the plan |
| P24 | A plan step depends on a library API | Verifies the API via library docs before writing the step, or marks it unverified |
| P25 | A migration with many dependencies | Uses structured thinking only when at least three triggers apply; keeps the conclusion, not the reasoning trail |
