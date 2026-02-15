# NEXUS Plugin Marketplace Submission

## Installation (Available Now)

### Via Claude Code Marketplace

1. In Claude Code, type `/plugin`
2. Add marketplace source: `https://github.com/Garrett-s-Apps/nexus-plugin`
3. Select NEXUS and install
4. Restart Claude Code

### Manual Installation

```bash
git clone https://github.com/Garrett-s-Apps/nexus-plugin.git ~/.claude/plugins/nexus
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

The marketplace.json file is located at `.claude-plugin/marketplace.json` and has the correct format:

```json
{
  "owner": {
    "name": "Garrett Eaglin",
    "url": "https://github.com/Garrett-s-Apps"
  },
  "plugins": [
    {
      "id": "nexus",
      "name": "NEXUS",
      "displayName": "NEXUS - Multi-Agent Engineering Org",
      "description": "Autonomous engineering organization with 26+ AI agents. Build features, review code, and track costs automatically.",
      "version": "0.1.0",
      "author": {
        "name": "Garrett Eaglin",
        "url": "https://github.com/Garrett-s-Apps"
      },
      "repository": {
        "type": "git",
        "url": "https://github.com/Garrett-s-Apps/nexus-plugin"
      },
      "license": "MIT",
      "homepage": "https://github.com/Garrett-s-Apps/nexus-plugin",
      "keywords": ["agents", "automation", "autonomous", "engineering", "code-review", "cost-tracking"],
      "categories": ["productivity", "development", "automation"],
      "features": [
        "Autonomous feature development (plan → implement → test → commit)",
        "Multi-perspective code review (style, quality, security, performance)",
        "Real-time cost tracking and budget enforcement",
        "26+ diverse AI agents with balanced representation"
      ],
      "installation": {
        "method": "git",
        "url": "https://github.com/Garrett-s-Apps/nexus-plugin.git"
      }
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
