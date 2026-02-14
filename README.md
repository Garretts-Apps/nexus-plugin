# NEXUS Claude Code Plugin

Multi-agent engineering organization with autonomous execution, cost tracking, and swappable AI providers.

## Installation

### Method 1: Clone to Plugins Directory (Recommended)

```bash
# Clone to Claude Code plugins directory
git clone https://github.com/Garrett-s-Apps/nexus-plugin.git ~/.claude/plugins/nexus

# Restart Claude Code (if running)
# Plugin will load automatically
```

### Method 2: Use with --plugin-dir Flag

```bash
# Clone anywhere
git clone https://github.com/Garrett-s-Apps/nexus-plugin.git ~/nexus-plugin

# Use with Claude Code
claude --plugin-dir ~/nexus-plugin
```

### Verify Installation

```bash
# Check if plugin is loaded
claude --list-plugins | grep nexus
```

## Quick Start

1. **Set up API key** (Claude Code will use your Claude key by default)
   ```bash
   # Optional: For other providers
   export OPENAI_API_KEY=sk-...
   export GOOGLE_API_KEY=...
   ```

2. **Use skills** (trigger automatically)
   ```
   "Build me a user authentication API"
   → Triggers autonomous-build skill

   "Review this code"
   → Triggers code-review-org skill

   "Show cost report"
   → Triggers cost-report skill
   ```

3. **Use commands** (explicit invocation)
   ```
   /nexus-status     # Show organization status
   /nexus-cost       # Display cost report
   /nexus-hire senior_engineer  # Add new agent
   ```

4. **Use agents** (via Task tool)
   ```
   Use the Task tool with nexus agents:
   - vp-engineering: Strategic planning
   - senior-engineer: Implementation
   - qa-lead: Quality assurance
   - security-engineer: Security review
   ```

## Features

### 🤖 Multi-Agent Orchestration
- 26-agent organization out of the box
- VP Engineering, Senior Engineers, QA Leads, Security Engineers
- Hierarchical decision making
- Parallel execution for speed

### 💰 Cost Tracking
- Real-time cost monitoring
- Budget enforcement (hourly/monthly)
- Model downgrade on budget approach
- Per-agent, per-project, per-model tracking

### 🔄 Provider Flexibility
- Default: Claude (via Claude Code)
- Optional: OpenAI, Gemini, local models
- Swap providers without code changes
- Zero cost when using Claude Code CLI

### 🚀 Autonomous Execution
- End-to-end feature implementation
- Planning → Implementation → QA → Git commit
- No manual intervention needed
- Production-quality code

### 👥 Diverse Representation
- 41.7% she/her, 33.3% he/him, 25.0% they/them
- Culturally diverse names
- Random balanced selection
- Inclusive by default

## Skills

### autonomous-build
**Triggers:** "build me", "create a", "implement"

Autonomous end-to-end feature development. Plans, implements, tests, and commits.

### code-review-org
**Triggers:** "review this", "code review"

Multi-perspective code review with parallel reviewers (style, quality, security, performance).

### cost-report
**Triggers:** "cost report", "budget status"

Comprehensive cost analysis with trends and optimization recommendations.

## Commands

### /nexus-status
Show organization status, active agents, system health.

### /nexus-cost
Display detailed cost report and budget tracking.

### /nexus-hire <role>
Add a new agent to the organization with balanced diversity.

## Agents

Available via Task tool for specialized work:

- **vp-engineering**: Strategic planning and architecture (Opus)
- **senior-engineer**: Feature implementation (Sonnet)
- **qa-lead**: Quality assurance and testing (Haiku)
- **security-engineer**: Security review and auditing (Sonnet)

## Configuration

### Environment Variables

```bash
# Provider API keys (optional - Claude Code provides Claude by default)
ANTHROPIC_API_KEY=sk-ant-...
OPENAI_API_KEY=sk-...
GOOGLE_API_KEY=...

# Budget configuration
NEXUS_HOURLY_TARGET=1.00       # Soft limit per hour
NEXUS_HOURLY_CAP=2.50          # Hard limit per hour
NEXUS_MONTHLY_TARGET=160.00    # Monthly budget target

# Model selection (for NEXUS server mode)
NEXUS_CONVERSATION_MODEL=sonnet
NEXUS_PLANNING_MODEL=opus
NEXUS_IMPLEMENTATION_MODEL=sonnet
NEXUS_QA_MODEL=haiku
```

### Permission Mode

NEXUS respects Claude Code's permission settings:
- **auto**: Skills execute automatically
- **acceptEdits**: Prompts for code changes only
- **prompt**: Prompts for all operations
- **deny**: Requires explicit approval

## How It Works

1. **User provides request** (e.g., "Build me a login API")

2. **Skill triggers** (autonomous-build detects intent)

3. **VP Engineering plans** (Opus creates technical design)

4. **Senior Engineers implement** (Sonnet writes production code)

5. **QA Lead reviews** (Haiku validates quality)

6. **Git commit** (Automatic with cost tracking)

7. **Report delivered** (Summary with files, cost, status)

## Cost Model

**Zero cost to you** - Users provide their own API keys:
- Claude Code users: $0 (uses Max subscription)
- Other providers: User's API cost only
- Cost tracking included free

**Typical costs** (when using API keys):
- Small feature: $0.10 - $0.50
- Medium feature: $0.50 - $2.00
- Large refactor: $2.00 - $5.00

Budget enforcement prevents runaway costs.

## Examples

### Build a complete feature
```
User: "Build me a user registration API with validation"

NEXUS:
1. VP plans: user model, validation rules, API endpoints
2. Engineer implements: routes, validation, database
3. QA reviews: edge cases, error handling
4. Commits: Creates branch, commits code
5. Reports: "Created 4 files, $0.42, ready to test"
```

### Multi-perspective code review
```
User: "Review the code in src/auth/"

NEXUS (parallel):
- Style Reviewer: "✓ Consistent naming, good structure"
- Quality Reviewer: "⚠️ Missing error handling in login()"
- Security Reviewer: "❌ Password not hashed, critical issue"
- Performance Reviewer: "✓ No obvious bottlenecks"

Verdict: NEEDS FIXES (security critical)
```

### Cost monitoring
```
User: "/nexus-cost"

NEXUS:
💰 Hourly: $0.82/hr (target: $1.00/hr) ✓
📊 Today: $6.54
📅 This Month: $127.40 / $160.00 (80%)
🎯 On track for: $152 monthly

Top consumers:
1. vp_engineering: $42.10
2. senior_engineer: $38.20
3. qa_lead: $8.15
```

## Troubleshooting

### "API key not configured"
- Claude Code: No action needed (uses your Claude subscription)
- Other providers: Set environment variables

### "Budget exceeded"
- Increase limits via environment variables
- Or wait for hourly window to reset

### "Agent not found"
- Use `/nexus-hire <role>` to add agent
- Or check spelling of agent ID

## Development

```bash
# Run tests
pytest tests/

# Type checking
mypy src/ packages/nexus-sdk/

# Linting
ruff check src/ packages/nexus-sdk/
```

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes with tests
4. Run quality checks (ruff, mypy, pytest)
5. Submit pull request

## License

MIT - See LICENSE file

## Support

- Issues: https://github.com/eaglin/nexus/issues
- Docs: https://nexus-sdk.dev/docs
- Email: support@nexus-sdk.dev
