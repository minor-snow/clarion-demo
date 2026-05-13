# Clarion Trial Report

**Repository:** my-flask-app
**Generated:** 2024-01-15T10:30:00Z
**Engine version:** 0.1.0

## Summary

| Metric | Value |
|--------|-------|
| Files analyzed | 47 |
| Governance surface | 8 files |
| Adoption complexity | Low |

## Governance surface

The following files were identified as governance-relevant:

| File | Reason | Confidence |
|------|--------|------------|
| `src/auth/permissions.py` | Security-sensitive, low change frequency | High |
| `src/auth/tokens.py` | Security-sensitive, low change frequency | High |
| `config/production.yml` | Infrastructure config | High |
| `src/models/user.py` | Core data model | Medium |
| `src/billing/calculator.py` | Business logic, low change frequency | Medium |
| `migrations/` | Schema changes | Medium |
| `Dockerfile` | Infrastructure | Low |
| `.github/workflows/deploy.yml` | CI/CD pipeline | Low |

## Recommended rules

```json
{
  "version": 1,
  "rules": [
    {
      "id": "protect-auth",
      "type": "protected-file",
      "target": "src/auth/permissions.py",
      "action": "fail"
    },
    {
      "id": "protect-tokens",
      "type": "protected-file",
      "target": "src/auth/tokens.py",
      "action": "fail"
    },
    {
      "id": "review-config",
      "type": "review-required",
      "target": "config/production.yml",
      "action": "warn"
    }
  ]
}
```

## PR patterns

- Average PR size: 23 lines
- Median PR size: 12 lines
- Files that change together: `src/models/*.py` + `migrations/`
- Hot spots: `src/api/routes.py` (changed in 40% of PRs)

## Adoption path

1. Add `pantheon.json` with the two auth file protections
2. Run `clarion check` in CI (non-blocking initially)
3. After 2 weeks, switch to blocking mode
4. Add review-required rules for config files
