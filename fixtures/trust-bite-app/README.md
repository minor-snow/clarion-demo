# trust-bite-app

A minimal Python application used as a fixture for the Clarion governance demo.

## Purpose

This fixture demonstrates that Clarion can detect a protected policy-file change and return a real non-pass governance result.

## Structure

```
src/
  policy_engine.py   — Protected: deterministic risk decision function
  app.py             — Application logic (not protected)
tests/
  test_policy_engine.py — Unit tests for the policy engine
pantheon.json        — Governance configuration (version 1 schema)
pantheon.alpha.json  — Byte-equivalent compatibility mirror of pantheon.json
AGENTS.md            — Human-readable projection of the machine policy
```

## The protected file

`src/policy_engine.py` is listed in both `pantheon.json` and `pantheon.alpha.json` under `protected`. In this fixture the two config files are intentionally byte-equivalent, and CI checks they stay in sync. Any unchecked modification to this file should cause `clarion check` to return a non-pass result.

## Running tests

```bash
cd src && python -m pytest ../tests/
```

Or directly:

```bash
python tests/test_policy_engine.py
```
