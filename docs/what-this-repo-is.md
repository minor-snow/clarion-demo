# What This Repo Is

## The public front door

This repository is the first thing a prospective Clarion user encounters. It serves as:

1. **A trust proof** — Demonstrates that Clarion enforcement is real and deterministic
2. **A bridge to trial** — Guides users from "see it work" to "try it on my code"
3. **A contract reference** — Documents the public CLI surface and stability guarantees
4. **An evidence index** — Curates conformance and safety documentation

## Design principles

- **Deterministic** — The demo produces the same result every time
- **Self-contained** — No external dependencies beyond the Clarion binary
- **Honest** — Does not overstate what the demo proves
- **Minimal** — Only includes what's needed to demonstrate the concept

## Relationship to other Clarion artifacts

| Artifact | Purpose |
|----------|---------|
| This repo | Public demo and trust proof |
| `clarion trial` | Full adoption evaluation on user's repo |
| Clarion source | The engine implementation (private) |
| Conformance harness | Full test suite (private) |
