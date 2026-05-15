# Trial Dogfood Matrix

This document tracks real-world Trial runs against diverse repositories to
identify failure modes, misleading recommendations, and lane readiness.

## Evaluation dimensions

Every dogfood run is scored on these 5 dimensions:

| Dimension | Definition | Example |
|-----------|-----------|---------|
| **False positive** | Should not have flagged, but did | Clean refactor flagged as risky |
| **False negative** | Should have flagged, but did not | Protected file changed without verdict |
| **Mode mismatch** | Wrong enforcement level | Advisory shown as blocking, or vice versa |
| **Recommendation drift** | Suggested lane does not match repo state | Recommends arch lane when no architecture doc exists |
| **Silent partial** | Appears to pass but lane did not actually run | PR lane shows "pass" but no diff was evaluated |

## Matrix template

| Repo | Type | Doctor | Scan | PR | Bug | Report | FP | FN | Mode | Rec drift | Silent partial | Notes |
|------|------|--------|------|-----|-----|--------|----|----|------|-----------|----------------|-------|
| _repo-1_ | Python small | | | | | | | | | | | |
| _repo-2_ | TS/JS frontend | | | | | | | | | | | |
| _repo-3_ | Mixed/monorepo | | | | | | | | | | | |
| _repo-4_ | Script repo (no tests) | | | | | | | | | | | |
| _repo-5_ | Active CI + real diffs | | | | | | | | | | | |

## How to fill this in

For each repo, run:

```bash
CLARION_BIN=/path/to/clarion ./scripts/trial-on-repo.sh /path/to/repo
```

Then evaluate:
1. Read `.clarion-trial/trial-doctor.log` — are the checks accurate?
2. Read `.clarion-trial/trial-scan.log` — are lane recommendations reasonable?
3. If PR lane ran, was the verdict correct for the actual diff?
4. If bug lane ran, was the scope honest about missing signals?
5. Did the bridge report (or canonical report) give a clear next step?

Score each dimension: `ok` / `issue` / `n/a`

## Completion criteria

The dogfood phase is complete when:
- At least 3 repos have been evaluated
- No blocking false negatives exist
- Recommendation drift is documented and either fixed or explicitly noted
- Silent partial cases are either eliminated or clearly labeled in output

## Current status

_Not yet started. This matrix will be filled during adoption surface hardening._
