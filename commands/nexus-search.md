# /nexus-search

**Description:** Search NEXUS knowledge base for past work, errors, and resolutions.

**Usage:**
```
/nexus-search <query>
/nexus-search --mode errors "authentication timeout"
/nexus-search --mode tasks --domain backend "rate limiting"
/nexus-search --mode code "router.py changes"
```

**Behavior:**

Activates the `semantic-search` skill:

1. **Parse Arguments**
   - Extract search query
   - Optional `--mode <mode>`: errors, tasks, code, conversations, all (default: all)
   - Optional `--domain <domain>`: frontend, backend, devops, security, testing

2. **Retrieval**
   - Encode query with NEXUS embeddings
   - Search knowledge store with filters
   - Apply chunk-type weighting and recency boost
   - Return top 5 results above similarity threshold

3. **Output**
   - Results ranked by weighted similarity score
   - Chunk type and age for each result
   - Metadata: agent, cost, files involved
   - Recommendations for follow-up actions

**Search Modes:**
- `errors`: Search error_resolution chunks only
- `tasks`: Search task_outcome chunks only
- `code`: Search code_change chunks only
- `conversations`: Search conversation chunks only
- `all`: Search all chunk types (default)

**Parameters:**
- `<query>` (required): Natural language search query
- `--mode <mode>` (optional): Filter by chunk type
- `--domain <domain>` (optional): Filter by domain classification
