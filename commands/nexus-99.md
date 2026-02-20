# /nexus-99

**Description:** AI pair-programming session backed by the full NEXUS 27-agent engine. Homage to ThePrimeagen's 99 — describe what you want changed and NEXUS engineers analyze and modify your code in real time.

**Usage:**
```
/nexus-99 <instruction>
/nexus-99 @src/ml/router.py fix the agent routing logic
/nexus-99 #security add rate limiting to the auth endpoint
/nexus-99 --edit src/config.py add the new REDIS_URL key
/nexus-99 --search "JWT validation"
/nexus-99 --debug
```

**Behavior:**

Activates an interactive pair-programming loop routed through the NEXUS engine:

1. **Parse Instruction**
   - Extract the instruction from command arguments
   - Parse `@file` prefixes — attach file context to the request
   - Parse `#rule` prefixes — load specific agent rules into context
   - Cleaned instruction is forwarded to NEXUS

2. **Route to NEXUS Engine**
   - POST to `http://localhost:4200/message` with `source: "99"`
   - Full 27-agent org executes: engineers analyze codebase, make edits, run tests
   - Response streamed back with structured output

3. **Display Response**
   - Show agent activity and output
   - Continue in REPL loop for follow-up instructions
   - Type `exit` or `quit` to end the session

**Modes:**

- **Default (REPL):** Interactive session — type instructions, get code changes, iterate
- **`--edit <file>`:** AI-assisted edit for a specific file
- **`--search <query>`:** Contextual codebase search backed by NEXUS knowledge base
- **`--debug`:** Root-cause analysis — NEXUS debugger agent analyzes recent errors

**Prefix Syntax:**

| Prefix | Example | Meaning |
|--------|---------|---------|
| `@file` | `@src/auth.py` | Attach this file as context |
| `#rule` | `#security` | Load the named rule into agent context |

**Parameters:**
- `<instruction>` (optional in REPL mode): What to build, edit, or debug
- `--edit <file>` (optional): Target a specific file for AI-assisted editing
- `--search <query>` (optional): Semantic codebase search
- `--debug` (optional): Trigger root-cause debug analysis

**Requirements:**
- NEXUS VM or local server must be running (`buildwithnexus start` or `./start.sh`)
- Server health endpoint must return OK at `http://localhost:4200/health`
