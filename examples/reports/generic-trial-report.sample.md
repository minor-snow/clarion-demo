# Clarion Trial Report

**Repository:** platform-monorepo
**Generated:** 2024-01-15T09:00:00Z
**Engine version:** 0.1.0

## Summary

| Metric | Value |
|--------|-------|
| Files analyzed | 340 |
| Governance surface | 18 files |
| Adoption complexity | High |

## Governance surface

| File | Reason | Confidence |
|------|--------|------------|
| `packages/auth/src/core.ts` | Authentication core | High |
| `packages/auth/src/oauth.ts` | OAuth implementation | High |
| `packages/billing/src/stripe.ts` | Payment integration | High |
| `infrastructure/terraform/main.tf` | Infrastructure definition | High |
| `infrastructure/terraform/iam.tf` | IAM policies | High |
| `packages/api/src/middleware/auth.ts` | API auth middleware | Medium |
| `packages/shared/src/crypto.ts` | Shared crypto utilities | Medium |
| `docker/production.Dockerfile` | Production container | Medium |
| `.github/workflows/deploy-prod.yml` | Production deployment | Medium |
| (9 more files) | Various | Low-Medium |

## Recommended rules

```json
{
  "version": 1,
  "governance": {
    "protected_files": [
      "packages/auth/src/core.ts",
      "packages/auth/src/oauth.ts",
      "packages/billing/src/stripe.ts",
      "infrastructure/terraform/iam.tf"
    ],
    "review_required": [
      "infrastructure/terraform/main.tf",
      "docker/production.Dockerfile",
      ".github/workflows/deploy-prod.yml"
    ]
  },
  "rules": [
    {
      "id": "protect-auth-core",
      "type": "protected-file",
      "target": "packages/auth/src/core.ts",
      "action": "fail"
    },
    {
      "id": "protect-iam",
      "type": "protected-file",
      "target": "infrastructure/terraform/iam.tf",
      "action": "fail"
    }
  ]
}
```

## PR patterns

- Average PR size: 67 lines
- Median PR size: 34 lines
- Large PRs (>200 lines): 12% of total
- Cross-package changes: 23% of PRs touch multiple packages

## Adoption path

1. **Phase 1** (Week 1-2): Protect auth and IAM files
2. **Phase 2** (Week 3-4): Add billing and infrastructure protections
3. **Phase 3** (Week 5-6): Add review-required rules for deployment
4. **Phase 4** (Ongoing): Expand based on incident patterns
