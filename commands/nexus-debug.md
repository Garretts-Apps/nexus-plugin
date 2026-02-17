# /nexus-debug

**Description:** Launch a semantic debug investigation on a specific error or failure.

**Usage:**
```
/nexus-debug <error description or stack trace>
/nexus-debug --file src/ml/router.py "agents being misrouted"
/nexus-debug --domain security "JWT validation failing on refresh"
```

**Behavior:**

Activates the `debug-investigate` skill with the provided error context:

1. **Parse Arguments**
   - Extract error description from command arguments
   - Optional `--file <path>` to focus on specific file
   - Optional `--domain <domain>` to pre-filter knowledge base (frontend/backend/devops/security/testing)

2. **Semantic Search Phase**
   - Query knowledge base for similar past errors
   - Display top matches with similarity scores
   - Highlight any proven resolutions

3. **Investigation Phase**
   - Debug Investigator agent analyzes error + knowledge context
   - Produces root cause hypothesis
   - Recommends fix with complexity estimate

4. **Output**
   - Structured investigation report
   - Past resolutions if available
   - Proposed fix with file:line references

**Parameters:**
- `<error>` (required): Error description, message, or stack trace
- `--file <path>` (optional): Focus investigation on specific file
- `--domain <name>` (optional): Pre-filter knowledge search by domain
