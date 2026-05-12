# Expected Checkpoints

After running `./scripts/run-demo.sh`, you should see these 5 checkpoints complete:

## Checkpoint 1: Architecture Observed

- `clarion dsa observe` returns `status: "ok"`
- Candidates discovered (≥1)
- No absolute paths in output

## Checkpoint 2: Work Items Created

- `clarion workgraph import-dsa` returns `status: "ok"`
- Work items appear in `clarion workgraph list`
- Each item has: id, status (open), tier

## Checkpoint 3: Agent Lifecycle Complete

- `clarion agent submit` returns `status: "ok"` or validates envelope
- `clarion agent progress` records progress event
- `clarion agent complete` marks session done

## Checkpoint 4: Route Recommendation Produced

- `clarion workgraph list --status open` shows ranked items
- Ranking is deterministic (same input → same order)
- Each item has tier and status metadata

## Checkpoint 5: Audit Trail Clean

- `clarion workgraph events` shows recorded events
- No absolute filesystem paths in any output
- No raw JSONL content leaked
- No stack traces in output

## Success Criteria

All 5 checkpoints complete = demo passes.
The governance layer is real. The "work being done" is simulated.
