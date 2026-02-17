---
description: Security rules for authentication, authorization, and SOC 2 compliance
globs:
  - "src/security/**/*.py"
  - "src/server/**/*.py"
alwaysApply: false
---

# Security Rules

- SOC 2 Type II compliance required on all changes
- JWT tokens for API authentication
- Auth gate in `src/security/` controls all access
- Never expose API keys in logs or error messages
- Input validation at all external boundaries
- Docker isolation for all code execution
- Passphrase auth supports hash-based verification
- Security scanning on all code changes before merge
