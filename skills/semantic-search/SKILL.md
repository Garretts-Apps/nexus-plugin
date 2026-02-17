---
description: Search NEXUS knowledge base for past errors, conversations, code changes, and task outcomes using semantic similarity
triggers:
  - search knowledge
  - find similar
  - have we done this before
  - past errors
  - what happened with
globs: []
alwaysApply: false
model: haiku
---

# Semantic Search Skill

**Triggers:** "search knowledge", "find similar", "have we done this before", "past errors", "what happened with"

**Description:** Exposes NEXUS's RAG knowledge base as a searchable skill. Finds past work, errors, resolutions, and conversations by semantic similarity rather than exact keyword match.

**Behavior:**

When the user wants to search institutional knowledge:

1. **Query Analysis**
   - Parse user's search intent
   - Classify domain: frontend, backend, devops, security, testing, general
   - Determine relevant chunk types to search

2. **Semantic Retrieval**
   - Encode query using NEXUS embeddings (`src/ml/embeddings.py`)
   - Search knowledge store with domain pre-filtering
   - Apply chunk-type weighting:
     - `error_resolution`: 1.3x (highest value — lessons learned)
     - `task_outcome`: 1.1x (what worked/failed)
     - `conversation`: 1.0x (prior Q&A)
     - `code_change`: 0.9x (what was built)
     - `directive_summary`: 0.8x (high-level outcomes)
   - Apply recency boost (up to 10% for chunks < 90 days old)
   - Return top 5 results above similarity threshold

3. **Result Presentation**
   - Display results with similarity scores and chunk types
   - Highlight actionable information (resolutions, agent recommendations)
   - Show metadata: when it happened, which agent, cost, files involved

4. **Follow-up Actions**
   - Offer to dive deeper into any result
   - Suggest related searches based on result metadata
   - Option to use findings as context for a new task

**Search Modes:**

| Mode | Chunk Types | Use Case |
|------|------------|----------|
| `errors` | error_resolution | "What errors have we seen with auth?" |
| `tasks` | task_outcome | "What tasks have we done for the API?" |
| `code` | code_change | "What code was changed for feature X?" |
| `conversations` | conversation | "What did we discuss about deployment?" |
| `all` (default) | all types | General search across everything |

**Example Usage:**

```
User: "have we done something like this before — building a rate limiter?"
```

**Output:**
```markdown
## Knowledge Search: "rate limiter"

### Results (3 matches found)

1. **[87% match] Task Outcome** — 12 days ago
   Task: "Implement API rate limiting middleware"
   Agent: senior_engineer_3 (succeeded)
   Cost: $0.28 | Duration: 3.2 min
   Files: src/server/middleware.py, src/config.py

2. **[72% match] Error Resolution** — 28 days ago
   Problem: "Rate limiter blocking WebSocket heartbeat connections"
   Resolution: Excluded /ws/* paths from rate limit middleware
   Domain: backend

3. **[61% match] Code Change** — 15 days ago
   Change: "Added sliding window rate limiter with Redis backend"
   Files: src/server/rate_limit.py, requirements.txt

### Recommendations
- Similar work has been done before (87% match)
- Estimated cost based on prior art: ~$0.25-0.35
- Recommended agent: senior_engineer_3 (succeeded previously)
- Watch out: WebSocket path exclusion needed (past error)
```

**Directive Similarity Integration:**

For new directives, this skill also leverages `src/ml/similarity.py` to provide:
- Prior art analysis (similar past directives)
- Cost estimation from historical data
- Risk assessment (failure rates of similar work)
- Agent performance recommendations

**Parameters:**
- Query: natural language description of what to search for
- Optional mode: `errors`, `tasks`, `code`, `conversations`, `all`
- Optional domain filter: `frontend`, `backend`, `devops`, `security`, `testing`

**Cost:** ~$0.001-0.01 (Haiku for formatting, no LLM needed for retrieval itself)
