# Spec: Cursor-Style Skills, Semantic Debug & RAG Search

**Version:** 1.0
**Date:** 2026-02-17
**Status:** Implemented
**Affects:** nexus-plugin (v0.2.0)
**Dependencies:** nexus server (RAG endpoints at localhost:4200)

## Summary

Upgrade nexus-plugin from a bare metadata manifest to a full Cursor-style skill system with YAML frontmatter, glob-based auto-attachment, agent @mention rules, and two new capabilities: semantic debugging and knowledge base search.

## Motivation

The nexus-plugin had three skills and three commands, but:
1. Skills lacked machine-readable metadata (no frontmatter, no triggers in plugin.json)
2. No debugging capability — errors had to be investigated from scratch every time
3. No access to NEXUS's RAG knowledge base from the plugin layer
4. No context rules — every interaction started cold without project conventions

Cursor's `.mdc` rule system and ThePrimeagen/99's `skills-v2` branch both demonstrate that structured, file-pattern-aware rules dramatically improve AI assistance quality. We adopted both patterns.

## What Changed

### Plugin Manifest (plugin.json v0.2.0)

| Field | Before | After |
|-------|--------|-------|
| skills | Not declared | 6 skills with triggers, globs, model tiers |
| commands | Not declared | 5 commands with descriptions |
| agents | Not declared | 5 agent personas with file references |
| rules | Not declared | contextWalk, mdFiles, customRulesDir |

### Skill System (Cursor .mdc Pattern)

Every SKILL.md now has YAML frontmatter:

```yaml
---
description: Human-readable description for AI discovery
triggers:
  - natural language trigger phrase
globs:
  - "src/**/*.py"
alwaysApply: false
model: sonnet
---
```

**Skill types** (matching Cursor's 4 rule types):

| Type | Activation | Example |
|------|-----------|---------|
| Always | `alwaysApply: true` | context-rules (loaded for every interaction) |
| Auto Attached | `globs` match current file | python-backend rule when editing .py files |
| Trigger | Natural language match | "debug" activates debug-investigate |
| Manual | Explicit `/nexus-*` command | `/nexus-debug`, `/nexus-search` |

### New Skills

#### debug-investigate
6-phase investigation combining traditional debugging with semantic search:
1. **Error Capture** — collect error details, classify domain
2. **Semantic Search** — query knowledge base for similar past errors (threshold 0.30)
3. **Context Assembly** — directory walk + agent rules + file scope (from 99 pattern)
4. **Root Cause Analysis** — correlate error + search results + code changes
5. **Resolution Proposal** — recommend proven fix (>70% match) or novel approach
6. **Knowledge Capture** — ingest error+resolution for institutional memory

#### semantic-search
5 search modes over the RAG knowledge base:
- `errors` — error_resolution chunks (permanent retention)
- `tasks` — task_outcome chunks (90d retention)
- `code` — code_change chunks (30d retention)
- `conversations` — conversation chunks (30d retention)
- `all` — search everything

#### context-rules
Always-on skill that provides three context sources:
1. **Directory Walk** (from ThePrimeagen/99) — walks upward collecting CLAUDE.md, AGENTS.md
2. **Custom Rules** (from Cursor .mdc) — `rules/*.md` with glob-based auto-attachment
3. **Agent @mentions** (from ThePrimeagen/99) — `@vp-engineering` loads agent persona as XML block

### New Agent

**debug-investigator** — Sonnet-tier agent specialized in root cause analysis, semantic error search, regression detection, and knowledge capture.

### New Commands

- `/nexus-debug <error> [--file path] [--domain name]` — launch debug investigation
- `/nexus-search <query> [--mode type] [--domain name]` — search knowledge base

### Custom Rules (rules/ directory)

| Rule | Globs | Purpose |
|------|-------|---------|
| python-backend.md | `src/**/*.py`, `tests/**/*.py` | Python conventions, ruff/mypy rules |
| ml-system.md | `src/ml/**/*.py` | ML system specifics, RAG config, thresholds |
| security.md | `src/security/**/*.py`, `src/server/**/*.py` | SOC 2, auth, Docker isolation |

## Architecture

```
nexus-plugin/
├── plugin.json              ← v0.2.0 manifest (skills, commands, agents, rules)
├── skills/
│   ├── autonomous-build/    ← existing (+ frontmatter)
│   ├── code-review-org/     ← existing (+ frontmatter)
│   ├── cost-report/         ← existing (+ frontmatter)
│   ├── debug-investigate/   ← NEW: semantic debugging
│   ├── semantic-search/     ← NEW: knowledge base search
│   └── context-rules/       ← NEW: always-on context loading
├── commands/
│   ├── nexus-status.md      ← existing
│   ├── nexus-cost.md        ← existing
│   ├── nexus-hire.md        ← existing
│   ├── nexus-debug.md       ← NEW
│   └── nexus-search.md      ← NEW
├── agents/
│   ├── vp-engineering.md    ← existing
│   ├── senior-engineer.md   ← existing
│   ├── qa-lead.md           ← existing
│   ├── security-engineer.md ← existing
│   └── debug-investigator.md ← NEW
└── rules/
    ├── python-backend.md    ← NEW (auto-attach for *.py)
    ├── ml-system.md         ← NEW (auto-attach for src/ml/*.py)
    └── security.md          ← NEW (auto-attach for security/server)
```

## Server Integration

The debug and search skills call NEXUS server endpoints:

| Skill | Server Endpoint | Purpose |
|-------|----------------|---------|
| debug-investigate | `POST /ml/debug` | Multi-phase error investigation |
| semantic-search | `POST /ml/rag/search` | Knowledge base search |
| semantic-search | `GET /ml/rag/status` | Knowledge base health |

See `nexus/docs/SPEC-RAG-DEBUG-ENDPOINTS.md` for endpoint details.

## Source Attribution

| Source | Pattern | Applied To |
|--------|---------|-----------|
| ThePrimeagen/99 `skills-v2` | SKILL.md discovery via directory globbing | All skills |
| ThePrimeagen/99 `skills-v2` | Agent rules as XML-tagged context blocks | @mention system |
| ThePrimeagen/99 `skills-v2` | RequestContext directory walk for .md files | context-rules skill |
| ThePrimeagen/99 `visual-selection` | Range-scoped operations | debug file:line targeting |
| Cursor IDE | `.mdc` YAML frontmatter (description, triggers, globs, alwaysApply) | All skills + rules |
| Cursor IDE | 4 rule types (Always, Auto Attached, Agent Requested, Manual) | Skill type system |

## Repos Not Changed

- **nexus-sdk**: No changes needed. The SDK provides provider-agnostic agent infrastructure (Claude/OpenAI/Gemini). The new skills are plugin-layer and server-layer concerns. SDK would only need changes if we added `DebugAgent` or `SearchProvider` base classes.

- **nexus-playground**: No changes needed. It's a research archive of 38+ iteration documents — not an active development target.
