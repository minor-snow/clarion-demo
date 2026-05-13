# Expected Verdict

When `clarion check` runs against the fixture after applying the protected-policy-change patch:

## Status

**non-pass** (fail)

## Envelope (JSON)

```json
{
  "version": "1.0",
  "command": "check",
  "status": "fail",
  "data": {
    "violations": [
      {
        "rule_id": "no-modify-policy-engine",
        "type": "protected-file",
        "file": "src/policy_engine.py",
        "message": "Protected file was modified without governance review"
      }
    ],
    "files_checked": 1,
    "rules_evaluated": 1
  }
}
```

## Human-readable summary

```
FAIL: Protected file violation

  Rule: no-modify-policy-engine
  File: src/policy_engine.py
  Message: Protected file was modified without governance review

1 violation found. Verdict: fail.
```

## Exit code

`1` (non-pass)
