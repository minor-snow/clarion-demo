# Agent Automation Path

This document explains how Clarion's automated agent flow should be adopted and
how it relates to the public demo in this repository.

## What "agent automation" means here

In Clarion terms, automated agent flow means:

1. A change or bug is identified.
2. Governance scope is declared or inferred.
3. Clarion evaluates whether the proposed work is allowed.
4. An agent edits only within the allowed scope.
5. Clarion evaluates the resulting change.
6. A human receives a governance result plus merge guidance.

The important point is not "the agent wrote code." The important point is:
the agent remains inside a governed change loop from start to finish.

## The minimal governed loop

The smallest honest automated flow looks like this:

```text
bug or change request
-> scope or contract
-> governed agent edit
-> clarion check
-> report / approval / retry
```

That is the full-flow target this repo documents.

## What this repo proves today

This public demo proves several prerequisites for agent automation:

- `demo-bite.sh` proves that protected policy-file changes produce a real non-pass result.
- `demo-review-required.sh` proves that review-sensitive surfaces produce a governance result.
- `demo-trial-empty-repo.sh` proves that Clarion is honest when a repo is not ready yet.
- `trial-on-repo.sh` proves that a user can be guided toward the right adoption lane.

These are the building blocks an automated agent lane depends on.

## What this repo does NOT prove yet

This repo does not currently ship a public script that runs a real coding agent
end-to-end under Clarion governance.

That means:
- the automated agent lane is documented here,
- its prerequisites are demonstrated here,
- but the runtime loop itself is not yet a public one-command demo in this repo.

This distinction is intentional. The docs should explain the full flow without
pretending the public repo already proves every step at runtime.

## Prerequisites before enabling automated agents

Do not start with the agent lane first.

Enable agent automation only after the following are already trustworthy:

1. **PR governance is stable**
   - You can run `clarion check` on real diffs.
   - The team trusts the verdicts and next actions.

2. **Protected and review-sensitive surfaces are declared**
   - Core files are listed in `pantheon.json`.
   - Human-facing rules are projected in `AGENTS.md`.

3. **CI is wired**
   - Governance runs automatically on proposed changes.
   - Reports and artifacts stay sanitized.

4. **The target task is scoped**
   - A bug title, failing test, or explicit change request exists.
   - The team knows what "done" means before the agent starts.

## Recommended rollout

### Stage 1 - Manual governance

Use Clarion as a deterministic reviewer:
- run `clarion check`
- observe non-pass vs pass
- tune protected and review-sensitive paths

### Stage 2 - Guided adoption

Use Trial to understand the repo:
- run `trial doctor`
- run `trial scan`
- run `trial pr`
- start using canonical reports when available

### Stage 3 - Narrow agent lane

Allow automation only on low-risk tasks:
- documentation edits
- test-only changes
- small scoped bug fixes

The key test here is whether Clarion catches out-of-scope or high-risk changes
before merge.

### Stage 4 - Full governed loop

Once the team trusts the verdicts, CI, and task scoping, the agent can operate
inside a repeatable governed flow:

```text
task intake
-> scope / contract
-> automated edit
-> clarion verdict
-> human approval or retry
```

## Honest public positioning

If you are showing this repo to a first-time user, the correct message is:

- Clarion already proves enforcement and adoption guidance.
- Clarion can support a governed automated agent loop.
- This repo documents that full flow honestly.
- The public runtime demo of that exact full loop is still a later step.

That is stronger than pretending a public one-command agent demo already exists.
It keeps the public surface aligned with what the repository actually proves.
