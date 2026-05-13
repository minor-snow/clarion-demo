# Scenario: Bite

This scenario demonstrates Clarion producing a governed non-pass result for an unchecked change to a protected policy file.

## Setup

- Fixture: `fixtures/trust-bite-app/`
- Protected file: `src/policy_engine.py`
- Governance config: `pantheon.json` and `pantheon.alpha.json` (version 1)

## The patch

`patches/protected-policy-change.patch` modifies `src/policy_engine.py` by changing the risk threshold logic. This is a legitimate-looking code change that an AI agent might propose.

## Expected result

When `clarion check` runs against the modified repository:

- **Status**: non-pass
- **Verdict**: `requires_contract`
- **Reason**: the protected policy-file change is surfaced as a contract-gated blocking result

See `expected/expected-verdict.md` for the full expected output.

## Running

```bash
./scripts/demo-bite.sh
```
