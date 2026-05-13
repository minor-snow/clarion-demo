# Expected Verdict

When `clarion check` runs against the fixture after applying the protected-policy-change patch:

## Status

**non-pass**

## Envelope (JSON)

```json
{
  "schema_version": "pantheon_cli_result@0.1.0",
  "command": "pantheon check",
  "target_type": "contract_gate",
  "status": "failed",
  "error_code": "missing_contract",
  "summary": {
    "risk_level": "critical",
    "contract_status": "missing",
    "reason_kinds": [
      "missing_contract"
    ]
  },
  "verdict": "requires_contract",
  "findings": [
    {
      "kind": "missing_contract",
      "severity": "blocking",
      "message": "critical-risk changes detected without a valid contract."
    }
  ]
}
```

## Human-readable summary

```
NON-PASS: Contract required

  Risk level: critical
  Contract status: missing
  Message: critical-risk changes detected without a valid contract.

Verdict: requires_contract
```

## Exit code

`1` (non-pass)
