# Scenario: Bite

This scenario demonstrates Clarion's enforcement of protected-file rules.

## Setup

- Fixture: `fixtures/trust-bite-app/`
- Protected file: `src/policy_engine.py`
- Governance config: `pantheon.json` (version 1)

## The patch

`patches/protected-policy-change.patch` modifies `src/policy_engine.py` by changing the risk threshold logic. This is a legitimate-looking code change that an AI agent might propose.

## Expected result

When `clarion check` runs against the modified repository:

- **Status**: non-pass (fail)
- **Reason**: Protected file `src/policy_engine.py` was modified
- **Rule triggered**: `no-modify-policy-engine`

See `expected/expected-verdict.md` for the full expected output.

## Running

```bash
./scripts/demo-bite.sh
```
