# Clarion Demo

Clarion governs AI-assisted code changes with executable checks, review boundaries, and adoption reports.

This repository is the public front door for trying Clarion.

## Choose your path

### 1. See Clarion enforce a rule

```bash
./scripts/demo-bite.sh              # protected -> non-pass
./scripts/demo-review-required.sh   # review_required -> governance state
```

Expected takeaway: Clarion produces a real non-pass result when a protected
surface changes, and surfaces governance attention when a review-required path
changes.

### 1b. See Trial on a bare repo (honest first-encounter)

```bash
./scripts/demo-trial-empty-repo.sh
```

Expected takeaway: Most repos do not have governance surfaces on day one. This
demo shows the realistic Trial output for a repo with no `ARCHITECTURE.md`, no
`AGENTS.md`, no CI, and no tests. The point is not the happy path; it is the
path most users will actually see first.

### 2. Try Clarion on your own repo

```bash
./scripts/trial-on-repo.sh /path/to/your/repo
```

Expected takeaway: Clarion tells you which governance lanes are useful in your
repository today.

This writes either:
- `.clarion-trial/report/clarion_trial_report.md` when the canonical Trial report is produced
- `.clarion-trial/bridge_report.md` when the wrapper has to fall back to collected lane logs

### 2b. Understand the automated agent path

Read:
- [docs/agent-automation-path.md](docs/agent-automation-path.md)
- [docs/adoption-path.md](docs/adoption-path.md)

Expected takeaway: agent automation is a governed adoption lane that comes
after trustworthy PR governance, not before it.

### 3. Inspect the public contract

Read:
- [PUBLIC-CONTRACT.md](PUBLIC-CONTRACT.md)
- [docs/conformance-evidence.md](docs/conformance-evidence.md)
- [docs/safety-boundaries.md](docs/safety-boundaries.md)

Expected takeaway: Clarion's external output is structured, sanitized, and does
not require reading private stores.

---

## What this demo proves

| Governance rule | Human-visible effect | Machine evidence |
|---|---|---|
| Protected files cannot be silently changed | Agent avoids or flags core policy edits | `demo-bite.sh` returns non-pass |
| Review-required files need human attention | Change is surfaced for governance review | `demo-review-required.sh` reports governance state |
| No raw output in shareable reports | Reports contain only sanitized summaries | `assert-output-safe.js` passes |
| No absolute paths in public artifacts | Local paths never leak into shared docs | `assert-output-safe.js` passes |

The third column is the point. Clarion has machine evidence, not just AI self-discipline.

---

## What this repo is

- The first public-facing entrypoint for Clarion
- A deterministic trust proof for governance verdicts
- A guided bridge into `clarion trial`
- A documented path toward governed agent automation
- A curated evidence index

## What this repo is NOT

- Not the Clarion source repository
- Not the full conformance harness
- Not a replacement for `clarion trial`
- Not a fake fixture pretending to be product state
