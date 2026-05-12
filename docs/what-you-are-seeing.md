# What You Are Seeing

This document explains what each checkpoint in the demo actually demonstrates
and why it matters.

## The Core Difference

Most AI coding tools work like this:

```
Task → Agent → Code Output
```

Clarion works like this:

```
Architecture Observation → Governed Work Items → Controlled Agent Entry →
Explainable Routing → Auditable Transcript
```

The difference is **governance**. Every step is observable, every decision is
traceable, and no agent acts without passing through a validated contract.

## Checkpoint by Checkpoint

### 1. Architecture Observation (`dsa observe`)

**What it does:** Scans your repository and discovers architectural facts —
modules, boundaries, dependencies, candidates for improvement.

**Why it matters:** Before any work happens, the system has machine-readable
knowledge of your architecture. This isn't just "reading files" — it's building
a structured world model that governance decisions can reference.

**The governance principle:** You can't govern what you can't see.

### 2. Work Item Import (`workgraph import-dsa`)

**What it does:** Converts approved architecture observations into tracked,
governed work items with status, tier, and affected module metadata.

**Why it matters:** Work items aren't just TODO items. They're governed units
with state machines (open → claimed → completed), conflict detection, and
join point identification. The Workgraph coordinates; it doesn't decide.

**The governance principle:** Work is tracked, not ad-hoc.

### 3. Agent Lifecycle (`agent submit/progress/complete`)

**What it does:** An agent enters the system through the Agent Gateway,
reports progress, and completes its work — all through validated envelopes.

**Why it matters:** The agent doesn't get raw access. It enters through a
contract that validates its envelope, checks prerequisites, and records
every lifecycle event. The Gateway records; it doesn't grant authority.

**The governance principle:** Agents are participants, not owners.

### 4. Route Recommendation (`workgraph list` with routing)

**What it does:** The routing engine produces ranked recommendations for
which work item an agent should tackle next, with explainable factors.

**Why it matters:** Routing is deterministic and traceable. You can ask
"why was this item ranked #1?" and get a concrete answer: status priority,
tier, conflict presence, claim status. Routing recommends; it never executes.

**The governance principle:** Decisions are explainable, not opaque.

### 5. Audit Transcript

**What it does:** Produces a structured record of everything that happened:
who did what, when, what conflicts were detected, what routes were recommended.

**Why it matters:** The transcript is projection-only — it doesn't create new
facts, it summarizes existing ones. No raw JSONL, no absolute paths, no stack
traces. It's safe to share and audit.

**The governance principle:** Everything is auditable.

## The Five Boundaries

Throughout the demo, these boundaries are enforced:

1. **Workgraph coordinates; Governance decides.** The workgraph tracks state but doesn't make verdicts.
2. **Agent Gateway records; it doesn't grant authority.** Submitting a session doesn't authorize action.
3. **Routing recommends; it never executes.** Recommendations are advisory, never automatic.
4. **Console invokes CLI; it doesn't write stores.** The UI is read-only.
5. **Projections are advisory; they never block.** Conflicts inform, they don't prevent.

These aren't just design choices — they're the reason Clarion is a governance
layer and not just another coding agent.
