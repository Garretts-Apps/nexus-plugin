# /nexus-status

**Description:** Show current NEXUS organization status, active agents, and system health.

**Usage:**
```
/nexus-status
```

**Behavior:**

Displays comprehensive status report including:

1. **Organization Overview**
   - Total agents in registry
   - Active agents (currently executing tasks)
   - Agent availability by role
   - Current org chart configuration

2. **System Health**
   - Server status (if running)
   - Database connections
   - API key status (configured/missing)
   - Background tasks running

3. **Recent Activity**
   - Last 5 completed tasks
   - Current tasks in progress
   - Failed tasks (if any)

4. **Resource Usage**
   - Memory usage
   - Active sessions
   - Database size

**Output Format:**
```markdown
# 🏢 NEXUS Organization Status

## Agents (26 total)
- ✓ VP Engineering (Opus)
- ✓ Senior Engineers x8 (Sonnet)
- ✓ QA Leads x4 (Haiku)
- ✓ Security Engineers x4 (Sonnet)
- ✓ Architects x2 (Opus)
[...]

## System Health: ✓ Healthy / ⚠️ Degraded / ❌ Down
- Server: ✓ Running on port 4200
- Database: ✓ Connected (~/.nexus/*.db)
- API Keys: ✓ Claude, OpenAI, Gemini configured
- Background Tasks: 3 active

## Recent Activity (last 5 tasks)
1. [2024-01-15 14:30] feature: User auth API ($0.42, 45s) ✓
2. [2024-01-15 13:15] refactor: Database layer ($0.18, 22s) ✓
3. [2024-01-15 12:00] bugfix: Login validation ($0.09, 15s) ✓
[...]

## Current Tasks
- [In Progress] Code review for PR #123 (QA Lead)
```

**No Parameters**
