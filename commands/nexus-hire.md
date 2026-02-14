# /nexus-hire

**Description:** Add a new agent to the NEXUS organization.

**Usage:**
```
/nexus-hire <role> [--model <opus|sonnet|haiku>]
```

**Behavior:**

Registers a new agent in the organization with diverse, balanced representation:

1. Randomly selects a name from the role's pool (balanced gender distribution)
2. Configures agent with appropriate model tier
3. Adds to registry
4. Confirms hire with agent details

**Parameters:**

- `<role>` (required): Agent role to hire
  - vp_engineering
  - senior_engineer
  - frontend_engineer
  - backend_engineer
  - qa_lead
  - security_engineer
  - architect
  - product_manager
  - designer

- `--model <tier>` (optional): Model tier to use
  - opus: Most capable, highest cost
  - sonnet: Balanced capability and cost (default)
  - haiku: Fastest, lowest cost

**Example:**
```
/nexus-hire senior_engineer

Output:
✓ Hired: Maya Thompson (she/her)
  Role: Senior Software Engineer
  Model: Sonnet
  Cost: ~$0.015/1K tokens
  ID: senior_engineer_4
```

**Diversity Stats:**
- 41.7% she/her
- 33.3% he/him
- 25.0% they/them
- Culturally diverse names

**Note:** Agent names are randomly selected for balanced representation.
