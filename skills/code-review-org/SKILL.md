# Code Review Organization Skill

**Triggers:** "review this code", "code review", "check my code", "review PR"

**Description:** Multi-perspective code review using parallel agent reviewers.

**Behavior:**

When the user requests a code review, this skill narrates each step:

0. **Environment Setup**
   - 📢 "Ensuring NEXUS VM is running..."
   - 📢 "Preparing secure review environment..."
   - 📢 "Loading code into isolated sandbox..."

1. **Review Dispatch**
   - 📢 "Spawning 4 specialized reviewers in parallel..."
   - 📢 "Style Reviewer (Haiku) - checking conventions..."
   - 📢 "Quality Reviewer (Sonnet) - analyzing logic..."
   - 📢 "Security Reviewer (Sonnet) - scanning for vulnerabilities..."
   - 📢 "Performance Reviewer (Sonnet) - checking efficiency..."

2. **Style Review** (Haiku - Fast)
   - 📢 "Checking naming conventions..."
   - 📢 "Validating formatting consistency..."
   - 📢 "Analyzing code organization..."
   - 📢 "Reviewing documentation quality..."

3. **Quality Review** (Sonnet - Thorough)
   - 📢 "Verifying logic correctness..."
   - 📢 "Checking error handling..."
   - 📢 "Testing edge cases..."
   - 📢 "Assessing maintainability..."
   - 📢 "Detecting anti-patterns..."

4. **Security Review** (Sonnet - Focused)
   - 📢 "Auditing authentication/authorization..."
   - 📢 "Validating input sanitization..."
   - 📢 "Scanning for SQL injection risks..."
   - 📢 "Checking for XSS vulnerabilities..."
   - 📢 "Detecting exposed secrets..."
   - 📢 "Reviewing OWASP Top 10 compliance..."

5. **Performance Review** (Sonnet - Analytical)
   - 📢 "Analyzing algorithmic complexity..."
   - 📢 "Checking database query efficiency..."
   - 📢 "Measuring memory usage..."
   - 📢 "Identifying caching opportunities..."
   - 📢 "Detecting N+1 query problems..."

6. **Consolidation**
   - 📢 "All reviewers complete! Consolidating findings..."
   - 📢 "Generating summary report..."
   - 📢 "Calculating overall verdict..."

**Parallel Execution:** All reviewers run simultaneously (steps 2-5 concurrent).

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
