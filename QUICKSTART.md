# Quick Start — Governed AI Change in 10 Minutes

## Prerequisites

- Node.js ≥ 20
- Clarion CLI installed or built locally
- This repository cloned

## Setup

### Option A: Use installed Clarion

```bash
npm install -g pantheon-alpha
```

### Option B: Point to local build

```bash
export CLARION_BIN=/path/to/clarion-release/dist/src/cli/pantheon.js
```

## Run the Demo

### Step 1: Bootstrap

```bash
./scripts/bootstrap.sh
```

This initializes the demo repository with Clarion governance and prepares the fixture app.

### Step 2: Run the Guided Demo

```bash
./scripts/run-demo.sh
```

The script walks you through 5 checkpoints. Each step pauses to show you what happened.

---

## The 5 Checkpoints

### Checkpoint 1: Observe Architecture

```bash
clarion dsa observe --json
```

Clarion scans the demo app and discovers architectural candidates — modules, boundaries, dependencies.

**What you see:** Candidates with evidence. The system now has machine-readable knowledge of your architecture.

### Checkpoint 2: Import Work Items

```bash
clarion dsa review approve <candidate-id> --reason "Demo scenario"
clarion dsa materialize --candidate <candidate-id>
clarion dsa project
clarion workgraph import-dsa --actor demo-operator
```

Architecture observations become governed work items in the Workgraph.

**What you see:** Work items with status, tier, and affected modules. These are trackable, claimable units of work.

### Checkpoint 3: Agent Lifecycle

```bash
clarion agent submit --envelope @envelopes/submit.json --json
clarion agent progress --envelope @envelopes/progress.json --json
clarion agent complete --envelope @envelopes/complete.json --json
```

An agent enters the system through the validated gateway. Every step is recorded.

**What you see:** The agent doesn't just "run code" — it enters through a contract, reports progress, and completes under governance.

### Checkpoint 4: Route Recommendation

```bash
clarion workgraph list --json
```

The routing engine produces ranked recommendations explaining which work item to tackle next and why.

**What you see:** Deterministic ranking with explainable factors. Not a black box — you can trace why each item is ranked where it is.

### Checkpoint 5: Audit Transcript

The final output shows the complete transcript of what happened:
- Who did what
- When they did it
- What conflicts or joins were detected
- No raw paths, no JSONL leaks, no stack traces

**What you see:** A clean, auditable record proving the entire workflow was governed.

---

## Reset

To start over:

```bash
./scripts/reset-demo-state.sh
```

This removes all `.pantheon/` state and returns the demo to a clean starting point.

---

## What's Next?

- Read [POSITIONING.md](POSITIONING.md) to understand where Clarion fits
- Read [docs/what-you-are-seeing.md](docs/what-you-are-seeing.md) for deeper explanation
- Visit the [public test repo](https://github.com/minor-snow/test) for the conformance harness
