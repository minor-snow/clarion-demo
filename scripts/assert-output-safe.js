#!/usr/bin/env node

const fs = require("node:fs");
const path = require("node:path");

const target = process.argv[2];

if (!target) {
  console.error("Usage: node scripts/assert-output-safe.js <file>");
  process.exit(2);
}

if (!fs.existsSync(target)) {
  console.error(`ERROR: File not found: ${target}`);
  process.exit(2);
}

const content = fs.readFileSync(target, "utf8");
const findings = [];

const checks = [
  {
    label: "absolute_windows_path",
    patterns: [/[A-Za-z]:\\\\/g, /[A-Za-z]:\\(?:Users|home|work|tmp|temp)\\/g],
  },
  {
    label: "absolute_unix_path",
    patterns: [/\/Users\//g, /\/home\//g, /\/var\//g],
  },
  {
    label: "raw_diff_hunk",
    patterns: [/^@@ /gm],
  },
  {
    label: "secret_like_token",
    patterns: [/OPENAI_API_KEY=/g, /GITHUB_TOKEN=/g, /\bghp_[A-Za-z0-9]+\b/g, /\bsk-[A-Za-z0-9]+\b/g],
  },
  {
    label: "raw_internal_store_dump",
    patterns: [/agent_gateway_events\.jsonl/g, /agent_envelopes\.jsonl/g, /work_events\.jsonl/g, /work_items\.jsonl/g],
  },
];

for (const check of checks) {
  for (const pattern of check.patterns) {
    const matched = content.match(pattern);
    if (matched && matched.length > 0) {
      findings.push(`${check.label}: ${matched[0]}`);
      break;
    }
  }
}

if (findings.length > 0) {
  console.error(`ERROR: Unsafe output detected in ${path.normalize(target)}`);
  for (const finding of findings) {
    console.error(`  - ${finding}`);
  }
  process.exit(1);
}

console.log(`PASS: ${path.normalize(target)} is safe for public output.`);
