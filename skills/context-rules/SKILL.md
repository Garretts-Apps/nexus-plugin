---
description: Auto-attach project rules and agent context based on file patterns and @mentions. Inspired by Cursor's .mdc rule system and ThePrimeagen/99's agent rules.
triggers: []
globs:
  - "**/*.py"
  - "**/*.ts"
  - "**/*.tsx"
  - "**/*.js"
  - "**/*.jsx"
alwaysApply: true
model: haiku
---

# Context Rules Skill

**Type:** Always-on (auto-attached when working with code files)

**Description:** Automatically discovers and attaches contextual rules to every AI interaction. Combines three sources:

1. **Directory Walk** — walks upward from current file collecting CLAUDE.md, AGENTS.md, NEXUS.md
2. **Custom Rules** — loads `.mdc` files from `rules/` directory matched by glob patterns
3. **Agent Rules** — resolves `@agent` mentions in prompts to load agent-specific context

This mirrors how Cursor's `.mdc` rule system and ThePrimeagen/99's agent rules work, adapted for the NEXUS plugin ecosystem.

## Rule Discovery

### 1. Directory Context Walk (from ThePrimeagen/99)
Starting from the current file's directory, walks upward to the project root collecting:
- `CLAUDE.md` — project-level AI instructions
- `AGENTS.md` — agent-specific conventions
- `NEXUS.md` — NEXUS-specific configuration

Each discovered file is prepended to the AI context, with deeper (more specific) files taking priority.

### 2. Custom Rules (Cursor `.mdc` pattern)
Files in the `rules/` directory with YAML frontmatter:

```yaml
---
description: What this rule does
globs:
  - "src/ml/**/*.py"
  - "src/agents/**/*.py"
alwaysApply: false
---

Rule content in markdown...
```

**Rule types:**
- **Always** (`alwaysApply: true`): Loaded for every interaction
- **Auto Attached** (`globs` match): Loaded when working with matching files
- **Agent Requested**: AI discovers rules by reading descriptions and loads as needed
- **Manual**: Only loaded when explicitly referenced with `@rulename`

### 3. Agent Rules (from ThePrimeagen/99 `@mention` system)
Prompts can reference agents with `@agent-name` syntax:
- `@vp-engineering` — loads VP planning context
- `@security-engineer` — loads security review context
- `@debug-investigator` — loads debugging context

Agent rules are read from `agents/*.md` and injected as XML-tagged context blocks:
```xml
<vp-engineering>
[agent file contents]
</vp-engineering>
```

## Integration with NEXUS Skills

When another skill activates (e.g., debug-investigate, autonomous-build), context-rules automatically provides:
- Project conventions from the directory walk
- Relevant custom rules matched by the files being worked on
- Agent context for any `@mentioned` specialists

This ensures every NEXUS operation has full project awareness without manual context loading.

## Rule Precedence
1. Always-on rules (loaded first)
2. Glob-matched rules (loaded when file patterns match)
3. Agent rules (loaded on `@mention`)
4. Directory walk context (deepest/most-specific wins on conflict)

**Cost:** Negligible (file reads only, no LLM calls for rule loading)
