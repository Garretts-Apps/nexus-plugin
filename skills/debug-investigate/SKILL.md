---
description: Deep debugging with semantic search over past errors, resolutions, and task outcomes from NEXUS knowledge base
triggers:
  - debug
  - investigate
  - why is this failing
  - root cause
  - trace error
  - what went wrong
globs: []
alwaysApply: false
model: sonnet
---

# Debug Investigate Skill

**Triggers:** "debug", "investigate", "why is this failing", "root cause", "trace error", "what went wrong"

**Description:** Deep debugging that combines traditional analysis with semantic search over NEXUS's knowledge base of past errors, resolutions, task outcomes, and code changes.

**Behavior:**

When the user reports a bug or asks to investigate a failure, this skill orchestrates a multi-phase investigation:

1. **Error Capture**
   - Collect the error message, stack trace, or failure description
   - Identify the affected file(s), function(s), and line number(s)
   - Classify the error domain: frontend, backend, devops, security, testing

2. **Semantic Search — Past Resolutions**
   - Query NEXUS knowledge base (`~/.nexus/knowledge.db`) for similar past errors
   - Search `error_resolution` chunks first (highest value — permanent retention)
   - Search `task_outcome` chunks for failed tasks with similar descriptions
   - Search `code_change` chunks for recent modifications to affected files
   - Rank results by weighted cosine similarity with recency boost
   - Present top 3 matches with similarity scores

3. **Context Assembly** (adapted from ThePrimeagen/99 pattern)
   - Walk directory tree upward from error location collecting CLAUDE.md, AGENTS.md context
   - Load any `@agent` rules mentioned in the investigation prompt
   - Attach file contents at error location with surrounding function scope
   - Include recent git history for affected files (`git log --oneline -10 <file>`)

4. **Root Cause Analysis** (Debug Investigator Agent — Sonnet)
   - Analyze error against collected context + semantic search results
   - Cross-reference with past resolutions to avoid repeating failed fixes
   - Identify the specific code path that triggered the failure
   - Determine if the error is a regression (compare with code_change history)
   - Produce a hypothesis with confidence level (high/medium/low)

5. **Resolution Proposal**
   - Generate a specific fix based on root cause analysis
   - If past resolution exists with >70% similarity, recommend the proven fix
   - If novel error, propose fix and flag for knowledge ingestion after resolution
   - Estimate fix complexity: trivial / moderate / significant

6. **Knowledge Capture**
   - After fix is applied and verified, ingest the error+resolution pair
   - Store as `error_resolution` chunk (permanent retention, highest retrieval weight)
   - Tag with domain classification for future pre-filtering
   - This builds institutional memory — the same error never requires full re-investigation

**Semantic Search Integration:**

The skill uses NEXUS's RAG system (`src/ml/rag.py`) with these retrieval parameters:
- `chunk_types`: `["error_resolution", "task_outcome", "code_change"]`
- `threshold`: 0.30 (lower than default — cast wider net for debugging)
- `top_k`: 8 (more candidates for cross-referencing)
- Domain pre-filtering based on error classification
- Chunk weights: error_resolution 1.3x, task_outcome 1.1x, code_change 0.9x

**Example Usage:**
```
User: "debug why the ML router is returning wrong agents"
```

**Investigation output:**
```markdown
## Debug Investigation: ML Router Agent Mismatch

### Error Classification
- Domain: backend (ML system)
- Files: src/ml/router.py, src/ml/store.py
- Severity: functional — wrong agent selection affects task quality

### Semantic Search Results
1. [82% match] Past error: "RandomForest classifier overfitting on small dataset"
   Resolution: Added minimum sample threshold of 20 before ML routing activates
2. [71% match] Task outcome: "ML router fallback to keyword matching succeeded"
   Agent: senior_engineer_2, Cost: $0.12
3. [58% match] Code change: "Updated TF-IDF vectorizer parameters in router.py"

### Root Cause Analysis (confidence: high)
The ML router's RandomForest model was retrained with skewed outcome data after
a batch of similar tasks. The TF-IDF feature extraction is weighting recent
task descriptions too heavily, causing specialty mismatch.

### Recommended Fix
1. Clear stale training data older than 30 days from task_outcomes
2. Add class balancing to RandomForest training (`class_weight='balanced'`)
3. Increase minimum training samples from 20 to 50

### Past Resolution Available
The 82% match resolution (minimum sample threshold) is directly applicable.
Extending the same pattern with class balancing addresses the root cause.

### Complexity: moderate
- 2 files modified, ~15 lines changed
- Requires retraining the model after fix
```

**Parameters:**
- User provides error description, stack trace, or "what went wrong" context
- Optional: specific file path to focus investigation
- Optional: `@agent` mentions to load domain-specific rules

**Cost:** ~$0.05-0.15 (Sonnet for analysis, Haiku for search retrieval)
