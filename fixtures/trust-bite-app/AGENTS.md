# Agent Rules — trust-bite-app

## Protected files

The following files are governed by Clarion and must not be modified by agents without governance review:

- `src/policy_engine.py` — Core risk decision logic. Changes trigger a non-pass verdict.

## Allowed modifications

Agents may freely modify:

- `src/app.py` — Application logic
- `tests/` — Test files
- Documentation files

## Governance config

- `pantheon.json` — Requires review to modify
- `pantheon.alpha.json` — Requires review to modify

## Rules

1. Do not modify `src/policy_engine.py` without explicit human approval.
2. Do not remove or weaken governance rules in `pantheon.json`.
3. All changes are subject to `clarion check` before merge.
