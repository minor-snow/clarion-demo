# Limitations

This demo is intentionally constrained. Here's what it does NOT show:

## Not Shown in This Demo

| Feature | Status | Where to Find It |
|---------|--------|-------------------|
| Multi-agent swarm (2+ agents) | Implemented | `clarion-release` test suite |
| Conflict detection between agents | Implemented | `clarion-release` swarm tests |
| Join point detection | Implemented | `clarion-release` swarm tests |
| Routing v2 (dependency/blast radius/capability) | Implemented | Golden fixtures in main repo |
| Local Review Console (browser UI) | Implemented | `npm run console` in main repo |
| Remote/cloud deployment | Not implemented | Not planned for current phase |
| Multi-repo governance | Not implemented | Not planned |
| LLM integration | Not implemented | Not planned |

## Demo Constraints

- **Single agent only.** The demo shows one agent lifecycle. Multi-agent coordination
  is proven in the test suite but not demonstrated here for simplicity.

- **Pre-approved candidates.** In real use, DSA candidates go through human review.
  The demo auto-approves for speed.

- **Local only.** Everything runs on your machine. No cloud, no remote services.

- **Fixed fixture.** The demo app is a small TypeScript project designed to produce
  interesting architectural observations. Real repos produce richer results.

## What's Real vs. Scripted

| Aspect | Real | Scripted |
|--------|------|----------|
| DSA observation | ✅ Real scan of fixture app | — |
| Work item creation | ✅ Real workgraph operations | — |
| Agent envelope validation | ✅ Real gateway validation | — |
| Routing recommendations | ✅ Real deterministic engine | — |
| Transcript generation | ✅ Real projection from events | — |
| The fixture app itself | — | ✅ Pre-built for demo |
| Candidate approval | — | ✅ Auto-approved for speed |
| Agent "doing work" | — | ✅ Simulated via envelopes |

The governance layer is real. The "work being done" is simulated.
That's the point — Clarion governs the process, it doesn't do the coding.
