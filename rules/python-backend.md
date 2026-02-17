---
description: Python backend conventions for NEXUS server code
globs:
  - "src/**/*.py"
  - "tests/**/*.py"
alwaysApply: false
---

# Python Backend Rules

- Use Python 3.11+ features (type unions with `|`, match statements)
- All `zip()` calls require `strict=` parameter (ruff B905)
- Use typed intermediate variables for serialized returns (mypy compliance)
- Use `_db` property pattern for optional `Connection` fields
- Comments explain WHY, never WHAT
- SOC 2 Type II compliance required on all changes
- Track token costs on every LLM operation
- CLI sessions ALWAYS run in Docker (`nexus-cli-sandbox`), never native
- ruff ignores: S101, E501, E701, E702, E731, S608, S603, S110, E402, SIM105, SIM108, SIM117
