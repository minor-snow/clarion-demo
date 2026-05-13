# Public Contract

This document defines the public surface of Clarion's CLI and its stability guarantees.

## CLI Envelope Format

All Clarion CLI commands that produce structured output use a JSON envelope:

```json
{
  "version": "1.0",
  "command": "<command-name>",
  "timestamp": "<ISO-8601>",
  "status": "pass | warn | fail | error",
  "data": { ... },
  "meta": {
    "engine_version": "<semver>",
    "repo": "<repo-root>"
  }
}
```

### Envelope fields

| Field | Type | Stability |
|-------|------|-----------|
| `version` | string | Stable — breaking changes bump major |
| `command` | string | Stable |
| `timestamp` | ISO-8601 string | Stable |
| `status` | enum | Stable — values will not be removed |
| `data` | object | Semi-stable — additive changes only |
| `meta` | object | Semi-stable — additive changes only |

## Public surface stability

The following are considered public surface and follow semver:

- CLI command names (`check`, `trial doctor`, `trial scan`, `trial pr`, `trial report`, `trial bug`)
- Envelope schema (top-level fields)
- Exit codes (0 = pass, 1 = non-pass, 2 = error)
- `pantheon.json` schema version 1

The following are NOT public surface:

- Internal engine implementation details
- `.pantheon/` directory structure
- Repair protocol internals
- Agent gateway format

## Safety boundaries

Clarion enforces the following safety boundaries:

1. **No code execution** — Clarion never executes repository code during checks
2. **No network calls** — All checks are local and offline
3. **No file mutation** — Clarion reads but never writes to your source files
4. **Deterministic output** — Same input always produces same output
5. **Bounded runtime** — Checks complete in bounded time proportional to repo size

See [docs/safety-boundaries.md](docs/safety-boundaries.md) for details.

## Versioning

- This contract follows semver
- Breaking changes require a major version bump
- Additive changes (new fields, new commands) are minor version bumps
- Bug fixes are patch bumps
