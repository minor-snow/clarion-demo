# trust-bite-app

A minimal Python application used as a fixture for the Clarion governance demo.

## Purpose

This fixture demonstrates that Clarion can detect and reject unauthorized modifications to protected files.

## Structure

```
src/
  policy_engine.py   — Protected: deterministic risk decision function
  app.py             — Application logic (not protected)
tests/
  test_policy_engine.py — Unit tests for the policy engine
pantheon.json        — Governance configuration (version 1 schema)
AGENTS.md            — Agent rules referencing protected files
```

## The protected file

`src/policy_engine.py` is listed in `pantheon.json` under `governance.protected_files`. Any modification to this file will cause `clarion check` to return a non-pass verdict.

## Running tests

```bash
cd src && python -m pytest ../tests/
```

Or directly:

```bash
python tests/test_policy_engine.py
```
