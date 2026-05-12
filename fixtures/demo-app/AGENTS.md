# AGENTS.md — Clarion Demo Fixture

This is a demo repository for Clarion governance.

## Rules

- All changes must go through `clarion check`
- Agents must submit envelopes through the Agent Gateway
- No direct `.pantheon/` edits

## Modules

- `src/auth/` — Authentication (login, session management)
- `src/api/` — API routes (depends on auth)
- `src/billing/` — Usage tracking
