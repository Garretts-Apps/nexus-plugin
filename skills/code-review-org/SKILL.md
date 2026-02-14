# Code Review Organization Skill

**Triggers:** "review this code", "code review", "check my code", "review PR"

**Description:** Multi-perspective code review using parallel agent reviewers.

**Behavior:**

When the user requests a code review, this skill spawns multiple reviewers in parallel:

1. **Style Reviewer** (Haiku - Fast)
   - Naming conventions
   - Formatting consistency
   - Code organization
   - Documentation quality

2. **Quality Reviewer** (Sonnet - Thorough)
   - Logic correctness
   - Error handling
   - Edge cases
   - Maintainability
   - Anti-patterns

3. **Security Reviewer** (Sonnet - Focused)
   - Authentication/authorization
   - Input validation
   - SQL injection risks
   - XSS vulnerabilities
   - Secret exposure
   - OWASP Top 10

4. **Performance Reviewer** (Sonnet - Analytical)
   - Algorithmic complexity
   - Database query efficiency
   - Memory usage
   - Caching opportunities
   - N+1 query problems

**Parallel Execution:** All reviewers run simultaneously for fast results.

**Example Usage:**
```
User: "Review the code in src/auth/"
```

All four reviewers analyze the code concurrently and provide consolidated feedback.

**Output Format:**
```markdown
## Code Review Summary

### Style (✓ Pass / ⚠️ Minor Issues / ❌ Major Issues)
- [Findings...]

### Quality (✓ Pass / ⚠️ Minor Issues / ❌ Major Issues)
- [Findings...]

### Security (✓ Pass / ⚠️ Minor Issues / ❌ Major Issues)
- [Findings...]

### Performance (✓ Pass / ⚠️ Minor Issues / ❌ Major Issues)
- [Findings...]

### Overall Verdict
[Ship It / Needs Minor Fixes / Needs Major Rework]

### Estimated Fix Time
[Time estimate if issues found]

### Total Review Cost
$X.XX
```

**Cost Optimization:** Uses Haiku for style (fast/cheap), Sonnet for deeper analysis.
