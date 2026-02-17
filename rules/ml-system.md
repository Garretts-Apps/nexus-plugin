---
description: ML system rules for agent routing, RAG, embeddings, and similarity search
globs:
  - "src/ml/**/*.py"
alwaysApply: false
---

# ML System Rules

- ML router uses TF-IDF + RandomForest trained on task_outcomes
- Falls back to keyword matching when <20 training samples
- RAG system uses cosine similarity with domain-tag pre-filtering
- Knowledge store uses WAL-mode SQLite at `~/.nexus/knowledge.db`
- ML training store at `~/.nexus/ml.db` — separate from knowledge store
- Chunk retention: error_resolution (permanent), task_outcome (90d), conversation (30d), code_change (30d)
- Embeddings generated via `src/ml/embeddings.py` — encode() returns numpy arrays
- Similarity threshold: 0.35 default, 0.30 for debug investigations
- Domain tags: frontend, backend, devops, security, testing, general
- Always record feedback after directive completion for continuous learning
