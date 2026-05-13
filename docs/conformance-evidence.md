# Conformance Evidence

This document indexes the evidence that Clarion's governance enforcement works as documented.

## Trust-bite proof

| Property | Evidence |
|----------|----------|
| Trust-bite enforcement | `./scripts/demo-bite.sh` produces a real non-pass governance result |
| Determinism | Same fixture + patch always produces same result |
| No bypass | Patch applied via git; no special agent path |
| Machine-readable output | JSON envelope with structured verdict, findings, and next actions |
| Human-readable output | Generated `bite-report.md` |

## Reproducibility

Anyone with the Clarion binary can reproduce the trust-bite:

```bash
git clone <this-repo>
./scripts/demo-bite.sh
```

The result is deterministic and does not depend on:
- Network access
- External services
- Time of day
- Operating system (beyond bash + git)

## CI evidence

The `.github/workflows/trust-bite.yml` workflow runs the bite demo on every push when the engine is available, providing continuous conformance evidence.

## Limitations

This evidence covers:
- Protected policy-file changes producing a governed non-pass result
- Non-pass verdict generation
- JSON envelope format

This evidence does NOT cover:
- All rule types (only one trust-bite path is demonstrated)
- Performance characteristics
- Integration with external CI systems
- Multi-rule interactions

See [limitations.md](limitations.md) for full details.
