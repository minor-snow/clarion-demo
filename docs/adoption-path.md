# Adoption Path

This document describes the expected journey from first contact to active
governance. It is honest about what works today and what requires setup.

## The realistic first encounter

Most repositories have none of the following on day one:
- `ARCHITECTURE.md`
- `pantheon.json` or `AGENTS.md`
- A test suite with failing-test signals
- CI workflows

When you run `clarion trial` on such a repo, you will see:
- `trial doctor`: partial (several checks fail)
- `trial scan`: needs_setup (most lanes unavailable)
- `trial report`: not produced

**This is normal.** The demo includes `demo-trial-empty-repo.sh` specifically
to show this state so you know what to expect.

## Smallest step to unlock value

The fastest path to a useful governance result:

1. Add a minimal `pantheon.json`:
   ```json
   {
     "version": 1,
     "protected": ["src/core.py"],
     "review_required": [],
     "generated": [],
     "path_roles": {}
   }
   ```

2. Make a change to the protected file.

3. Run `clarion check --repo . --json`.

You now have a machine-verifiable governance result. No CI, no architecture
doc, no test suite required.

## Lane unlock order

Each governance lane has prerequisites. Unlock them in this order for the
smoothest adoption:

| Lane | Prerequisite | What it gives you |
|------|-------------|-------------------|
| **PR** | A diff (uncommitted changes or branch comparison) | Governance verdict on proposed changes |
| **Bug** | A test directory + a failing test or bug title | Scoped repair with governance boundaries |
| **Arch** | `ARCHITECTURE.md` or `docs/architecture*` | Boundary mapping and violation detection |
| **Agent** | Explicit configuration + stable PR lane | Scheduler-controlled AI under governance |

## Recommended adoption sequence

```
Week 1:  Add pantheon.json → run demo-bite equivalent → see non-pass
Week 2:  Add AGENTS.md → run trial pr on a real diff → see governance preview
Week 3:  Add CI workflow with clarion check → automated PR gate
Week 4+: Add test directory → enable bug lane
         Add ARCHITECTURE.md → enable arch lane
         Configure agent scheduler → enable agent lane
```

## What NOT to do

- Do not try to enable all lanes at once
- Do not add `ARCHITECTURE.md` before PR governance is stable
- Do not enable agent scheduler before you trust PR verdicts
- Do not treat partial/unavailable as failure — it is honest status

## From demo to production

| Demo command | Production equivalent |
|---|---|
| `demo-bite.sh` | `clarion check --repo . --json` in CI |
| `demo-review-required.sh` | PR comment with governance preview |
| `trial-on-repo.sh` | `clarion trial report --repo .` |
| `demo-trial-empty-repo.sh` | First-time `clarion trial doctor` |

The demo scripts are wrappers. The production path uses the Clarion CLI directly.
