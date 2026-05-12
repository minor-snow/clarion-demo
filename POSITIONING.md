# Positioning

## What is this repo?

`clarion-demo` is the guided first-use experience for Clarion. It contains a single
golden-path demo that shows the full governed AI workflow in 10 minutes.

This is an **adoption repo** — its job is to make someone understand Clarion's value
on first contact.

## What is it not?

| It is NOT | That lives here |
|-----------|-----------------|
| The Clarion source code | `clarion-release` (private) |
| The conformance harness | `github.com/minor-snow/test` |
| A test suite | Conformance tests are in the public test repo |
| A feature showcase | It shows ONE workflow, not all features |
| Documentation | Operator docs are in the main repo's `docs/operator/` |

## How is it different from `minor-snow/test`?

| | `clarion-demo` | `minor-snow/test` |
|---|---|---|
| **Purpose** | First-use adoption | Contract verification |
| **Audience** | New evaluators | Existing users / CI |
| **Scope** | One golden path | Full CLI surface coverage |
| **Tone** | Guided, narrative | Mechanical, exhaustive |
| **Success metric** | "I get it in 10 minutes" | "All 32 commands conform" |
| **Updates** | When the story changes | When the contract changes |

## The One Thing to Remember

Clarion is not a coding agent. It's a governance layer.

The demo exists to make that distinction viscerally clear in under 10 minutes.
