# Conformance Evidence

This document indexes the evidence that Clarion's governance enforcement works as documented.

## Trust-bite proof

| Property | Evidence |
|----------|----------|
| Trust-bite enforcement | `./scripts/demo-bite.sh` produces a real non-pass governance result |
| Governance verdict determinism | Same fixture + patch yields the same verdict and structured CLI envelope |
| No bypass | Patch applied via git; no special agent path |
| Machine-readable output | Local `artifacts/bite/result.json` stores the CLI envelope |
| Human-readable output | `artifacts/bite/bite-report.md` stores a sanitized summary |

## Reproducibility

Anyone with the Clarion binary can reproduce the trust-bite:

```bash
git clone <this-repo>
./scripts/demo-bite.sh
```

The governance evaluation result is deterministic and does not depend on:
- Network access
- External services
- Time of day
- Operating system (beyond bash + git)

The human-readable report includes a timestamp and is therefore not byte-for-byte deterministic.

## CI evidence

The `.github/workflows/trust-bite.yml` workflow runs the bite demo on every push when the engine is available, providing continuous conformance evidence.

## Limitations

This evidence covers:
- Protected policy-file changes producing a governed non-pass result
- Non-pass verdict generation
- Current `clarion check --json` envelope shape

This evidence does NOT cover:
- All rule types (only one trust-bite path is demonstrated)
- Performance characteristics
- Integration with external CI systems
- Multi-rule interactions
- Public runtime proof of a full automated coding-agent loop

See [limitations.md](limitations.md) for full details.
