# Interpreting the Trial Output

When Clarion CLI produces a canonical Trial report, it is written to `.clarion-trial/clarion_trial_report.md`.

If the canonical report is unavailable for the current repo state, the wrapper in
this repo writes `.clarion-trial/bridge_report.md` instead and keeps the raw lane
logs beside it. The bridge report is wrapper-owned and is not a canonical Clarion
Trial report.

## Canonical report sections

### Summary

High-level overview:
- Number of files analyzed
- Governance surface area
- Adoption complexity

### Governance surface

Files and directories identified as governance-relevant:
- Configuration files
- Security-sensitive code
- Core business logic
- Infrastructure definitions

### Recommended rules

Suggested governance rules based on repo patterns:
- Protected files
- Review-required paths
- Change-size thresholds

### Adoption path

Suggested steps to adopt Clarion:
1. Start with the highest-confidence protected files
2. Add review-required rules for sensitive paths
3. Integrate `clarion check` into CI
4. Expand rules as confidence grows

## Bridge report sections

The wrapper-owned bridge report focuses on:
- Exit codes for each Trial step
- Collected lane logs
- Recommended next step when the canonical report could not be produced
