# Clarion Trial Report

**Repository:** my-next-app
**Generated:** 2024-01-15T14:22:00Z
**Engine version:** 0.1.0

## Summary

| Metric | Value |
|--------|-------|
| Files analyzed | 132 |
| Governance surface | 12 files |
| Adoption complexity | Medium |

## Governance surface

| File | Reason | Confidence |
|------|--------|------------|
| `src/lib/auth.ts` | Authentication logic | High |
| `src/lib/crypto.ts` | Cryptographic operations | High |
| `src/middleware/rbac.ts` | Access control | High |
| `prisma/schema.prisma` | Database schema | High |
| `src/lib/billing.ts` | Payment processing | Medium |
| `src/lib/rate-limiter.ts` | Security control | Medium |
| `.env.example` | Environment template | Medium |
| `next.config.js` | Framework config | Medium |
| `docker-compose.yml` | Infrastructure | Low |
| `src/types/api.ts` | API contract types | Low |
| `tsconfig.json` | Build config | Low |
| `.github/workflows/deploy.yml` | Deployment pipeline | Low |

## Recommended rules

```json
{
  "version": 1,
  "rules": [
    {
      "id": "protect-auth",
      "type": "protected-file",
      "target": "src/lib/auth.ts",
      "action": "fail"
    },
    {
      "id": "protect-crypto",
      "type": "protected-file",
      "target": "src/lib/crypto.ts",
      "action": "fail"
    },
    {
      "id": "protect-rbac",
      "type": "protected-file",
      "target": "src/middleware/rbac.ts",
      "action": "fail"
    },
    {
      "id": "review-schema",
      "type": "review-required",
      "target": "prisma/schema.prisma",
      "action": "warn"
    }
  ]
}
```

## PR patterns

- Average PR size: 45 lines
- Median PR size: 28 lines
- Files that change together: `prisma/schema.prisma` + `src/types/api.ts`
- Hot spots: `src/app/` directory (changed in 65% of PRs)

## Adoption path

1. Start with auth/crypto/rbac protections (highest confidence)
2. Add schema review-required rule
3. Integrate `clarion check` into GitHub Actions
4. Expand to billing and rate-limiter after initial adoption
