# Public Contract

This repository documents only the Clarion surfaces it can verify against the
current shipped CLI. It must not invent a schema ahead of the product.

## Current demonstrated machine-readable surface

The verified JSON surface in this repo is `clarion check --json`.

The authoritative contract is the current CLI output itself. The sanitized
samples under `examples/cli/` are derived from real command output and are
included only as public-facing examples.

Example current shape:

```json
{
  "schema_version": "pantheon_cli_result@0.1.0",
  "command": "pantheon check",
  "target_type": "contract_gate",
  "status": "ok | failed",
  "summary": { "...": "..." },
  "verdict": "pass | requires_contract | ...",
  "findings": [],
  "next_actions": [],
  "next_action_intents": [],
  "artifact_paths": [],
  "warnings": [],
  "errors": [],
  "privacy": { "...": "..." },
  "details": { "...": "..." }
}
```

### Top-level fields currently evidenced

| Field | Meaning |
|-------|---------|
| `schema_version` | Identifies the current CLI envelope family |
| `command` | Command that produced the envelope |
| `target_type` | Evaluation surface targeted by the command |
| `status` | High-level command outcome |
| `summary` | Short structured summary |
| `verdict` | Governance verdict |
| `findings` | Structured findings |
| `next_actions` | Human-readable next steps |
| `next_action_intents` | Structured next-step intents when available |
| `artifact_paths` | Local artifact references when available |
| `warnings` | Non-blocking warnings |
| `errors` | Blocking or command-level errors |
| `privacy` | Disclosure boundary metadata |
| `details` | Additional structured details |

## Trial surface in this repo

`clarion trial` is demonstrated here as a human-readable adoption flow.

This repo does not claim a stable JSON envelope for Trial lanes unless the
shipped CLI actually emits one. The wrapper script in this repo,
`scripts/trial-on-repo.sh`, is not the Clarion CLI. When the canonical
`clarion trial report` output is unavailable, the wrapper writes
`.clarion-trial/bridge_report.md`.

## Fixture config compatibility

The trust-bite fixture uses the current public compatibility shape:

```json
{
  "version": 1,
  "protected": [],
  "review_required": [],
  "generated": [],
  "path_roles": {
    "<path-or-glob>": "<role-label>"
  }
}
```

In this fixture:
- `pantheon.json` is the compatibility machine source
- `pantheon.alpha.json` is a byte-equivalent mirror kept for compatibility
- CI checks that the two files stay identical

## Safety expectations for public samples

Public samples in this repo must be sanitized:
- No absolute local filesystem paths
- No raw diff hunks in human-facing docs
- No raw internal store dumps
- No secret-like payloads

## Not part of the public contract in this repo

The following are explicitly not promised here:
- Internal engine implementation details
- `.pantheon/` directory structure
- Wrapper-owned bridge report shape
- Repair protocol internals
- Agent gateway internal formats
