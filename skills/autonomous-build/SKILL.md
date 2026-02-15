# Autonomous Build Skill

**Triggers:** "build me", "create a", "make a", "implement", "ship"

**Description:** Autonomous end-to-end feature implementation with multi-agent orchestration.

**Behavior:**

When the user requests a new feature or project, this skill:

0. **First-Time Setup** (if needed)
   - Runs interactive scaffolding (VM creation, Docker build)
   - User sees progress and can confirm each step
   - Only runs once - subsequent uses skip this step
   - All execution happens in isolated VM+Docker environment

1. **Planning Phase** (VP of Engineering)
   - Analyzes requirements
   - Creates technical design
   - Plans file structure
   - Identifies dependencies

2. **Implementation Phase** (Senior Engineers)
   - Writes production-quality code
   - Handles error cases
   - Adds appropriate comments
   - Follows project conventions

3. **Quality Assurance** (QA Lead)
   - Reviews implementation
   - Checks for bugs
   - Validates error handling
   - Confirms completeness

4. **Version Control** (if Git detected)
   - Creates feature branch
   - Stages files
   - Commits with descriptive message
   - Includes cost tracking

5. **Reporting**
   - Summarizes what was built
   - Lists files created/modified
   - Reports total cost
   - Provides next steps

**Cost Awareness:** Uses budget-appropriate models (Opus for planning, Sonnet for implementation, Haiku for QA).

**Example Usage:**
```
User: "Build me a user authentication API"
```

The skill will autonomously plan, implement, test, and commit a complete authentication system.

**Parameters:**
- User provides high-level description
- All implementation details determined autonomously
- No follow-up questions unless requirements are ambiguous

**Output:**
- Working code committed to Git
- Cost report
- Quality assessment
- Ready-to-test implementation
