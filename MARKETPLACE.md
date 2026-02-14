# NEXUS Plugin Marketplace Submission

## Installation (Available Now)

```bash
claude install https://github.com/Garrett-s-Apps/nexus-plugin
```

## For Official Marketplace Submission

### Requirements Checklist

✅ **GitHub Repository:** https://github.com/Garrett-s-Apps/nexus-plugin
✅ **plugin.json:** Valid manifest with name, description, version
✅ **README.md:** Installation and usage documentation
✅ **Skills:** 3 skills with trigger patterns and behavior docs
✅ **Agents:** 4 agent definitions with system prompts
✅ **Commands:** 3 slash commands with clear documentation

### Submission Process

1. **Ensure Quality:**
   - Clear documentation ✅
   - Working examples ✅
   - No broken links ✅
   - Professional README ✅

2. **Submit via Anthropic:**
   - Contact: https://www.anthropic.com/claude-code
   - Provide GitHub URL
   - Wait for review (1-2 weeks typically)

3. **Community Marketplace (Alternative):**
   - Create marketplace.json (see below)
   - List in community marketplace
   - No review required

---

## Community Marketplace Setup

Create a `marketplace.json` in your repo root:

```json
{
  "name": "nexus",
  "displayName": "NEXUS - Multi-Agent Engineering Org",
  "description": "Autonomous engineering organization with 26+ AI agents. Features autonomous build, code review, and cost tracking.",
  "version": "0.1.0",
  "author": "Garrett Eaglin",
  "repository": "https://github.com/Garrett-s-Apps/nexus-plugin",
  "homepage": "https://github.com/Garrett-s-Apps/nexus-plugin",
  "license": "MIT",
  "keywords": [
    "agents",
    "automation",
    "autonomous",
    "engineering",
    "code-review",
    "cost-tracking",
    "multi-agent"
  ],
  "categories": [
    "productivity",
    "development",
    "automation"
  ],
  "installCommand": "claude install https://github.com/Garrett-s-Apps/nexus-plugin",
  "features": [
    "Autonomous feature development (plan → implement → test → commit)",
    "Multi-perspective code review (style, quality, security, performance)",
    "Real-time cost tracking and budget enforcement",
    "26+ diverse AI agents with balanced representation",
    "3 auto-triggered skills, 4 specialized agents, 3 commands"
  ],
  "requirements": {
    "claudeCode": ">=1.0.0"
  },
  "screenshots": [
    "https://github.com/Garrett-s-Apps/nexus-plugin/blob/main/screenshots/autonomous-build.png",
    "https://github.com/Garrett-s-Apps/nexus-plugin/blob/main/screenshots/code-review.png"
  ],
  "documentation": "https://github.com/Garrett-s-Apps/nexus-plugin/blob/main/README.md"
}
```

Then users can browse community marketplaces and find your plugin.

---

## Quick Distribution Options

### Option A: Share GitHub URL (Easiest)
```
Install NEXUS plugin:
claude install https://github.com/Garrett-s-Apps/nexus-plugin
```

### Option B: Add Install Badge to README
```markdown
[![Install with Claude Code](https://img.shields.io/badge/Install-Claude%20Code-blue)](https://github.com/Garrett-s-Apps/nexus-plugin)
```

### Option C: Create Landing Page
Simple webpage at `nexus-plugin.dev` with:
- One-click install instructions
- Feature showcase
- Video demo
- Documentation links

---

## Testing Installation

```bash
# Test fresh install
claude uninstall nexus  # Remove if already installed
claude install https://github.com/Garrett-s-Apps/nexus-plugin

# Verify installation
claude --list-plugins | grep nexus

# Test skills
# Just say: "Build me a hello world API"
# Should trigger autonomous-build skill
```

---

## Promoting Your Plugin

1. **Add to README.md:**
   ```markdown
   ## Installation

   ```bash
   claude install https://github.com/Garrett-s-Apps/nexus-plugin
   ```
   ```

2. **Create Releases:**
   ```bash
   git tag v0.1.0
   git push origin v0.1.0
   gh release create v0.1.0 --notes "Initial release"
   ```

3. **Share on Social:**
   - Twitter/X: "#ClaudeCode plugin for autonomous engineering"
   - Reddit: r/ClaudeAI
   - LinkedIn: Professional network
   - Dev.to: Blog post about building it

4. **List in Directories:**
   - Awesome Claude Code (GitHub)
   - Claude Code Community Marketplace
   - AI Tools directories

---

## Support & Updates

**GitHub Issues:** https://github.com/Garrett-s-Apps/nexus-plugin/issues
**Versioning:** Semantic versioning (v0.1.0, v0.2.0, v1.0.0)
**Changelog:** Update plugin.json version + create GitHub release

Users will automatically get updates when you push to main (if they reinstall or update).
