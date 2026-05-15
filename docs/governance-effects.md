# Governance Effects

Clarion governance affects a project in two ways:

## 1. Behavior shaping

These rules guide AI and human contributors before a violation happens.

Examples:
- Local-only network binding
- Type discipline
- Preferred libraries and patterns
- State-management rules

Behavior shaping is declared in `AGENTS.md` and `pantheon.json` path roles.
It reduces mistakes by making the right path obvious.

## 2. Machine enforcement

These checks produce concrete results when risky changes occur.

Examples:
- Protected file changed → non-pass verdict
- Review-required file changed → requires_review
- Missing contract → requires_contract
- Unsafe public artifact → withheld

Machine enforcement is executed by the Clarion CLI and produces a structured
JSON envelope that can be checked in CI, stored as evidence, or surfaced in
a human-readable report.

## Why both matter

Behavior shaping reduces mistakes.
Machine enforcement prevents silent bypass.

A project with only behavior shaping has no proof that rules are followed.
A project with only machine enforcement catches problems too late.
Clarion provides both, and this demo shows how they connect.

## How this demo demonstrates both

| Layer | Mechanism | Evidence |
|-------|-----------|----------|
| Behavior shaping | `AGENTS.md` declares protected files | Agent avoids modifying `src/policy_engine.py` |
| Machine enforcement | `clarion check` evaluates the diff | `demo-bite.sh` produces a non-pass result |
| Artifact safety | `assert-output-safe.js` scans reports | No absolute paths or raw output in shared docs |

## Limitations

Not every governance rule has machine enforcement today. Some rules are
advisory (behavior shaping only). The [rule-to-evidence map](rule-to-evidence.md)
makes this distinction explicit for every rule demonstrated in this repo.
