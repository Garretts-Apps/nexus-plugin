# Autonomous Build Skill

**Triggers:** "build me", "create a", "make a", "implement", "ship"

**Description:** Autonomous end-to-end feature implementation with multi-agent orchestration.

**Behavior:**

When the user requests a new feature or project, this skill narrates each step:

0. **First-Time Setup** (if needed)
   - 📢 "Setting up NEXUS secure execution environment..."
   - 📢 "Installing Multipass VM manager..."
   - 📢 "Creating Ubuntu VM with SOC 2 Type II hardening..."
   - 📢 "Building Docker sandbox container..."
   - 📢 "Configuring security policies and isolation..."
   - User sees all progress and confirms each step
   - Only runs once - subsequent uses skip to step 1

1. **Environment Check**
   - 📢 "Checking if NEXUS VM is running..."
   - 📢 "Starting secure execution environment..." (if needed)
   - 📢 "All code will execute in isolated VM+Docker sandbox"

2. **Planning Phase** (VP of Engineering)
   - 📢 "VP of Engineering analyzing requirements..."
   - 📢 "Creating technical architecture design..."
   - 📢 "Planning file structure and module boundaries..."
   - 📢 "Identifying dependencies and risks..."
   - Shows the technical plan to user

3. **Implementation Phase** (Senior Engineers)
   - 📢 "Senior Engineers implementing feature..."
   - 📢 "Writing production-quality code..."
   - 📢 "Handling error cases and edge conditions..."
   - 📢 "Following project conventions and best practices..."
   - Shows files being created/modified

4. **Quality Assurance** (QA Lead)
   - 📢 "QA Lead reviewing implementation..."
   - 📢 "Checking for bugs and logic errors..."
   - 📢 "Validating error handling..."
   - 📢 "Confirming completeness and quality..."
   - Shows QA findings and fixes

5. **Version Control** (if Git detected)
   - 📢 "Creating feature branch..."
   - 📢 "Staging modified files..."
   - 📢 "Committing with descriptive message..."
   - 📢 "Tracking cost and metadata..."
   - Shows branch name and commit hash

6. **Reporting**
   - 📢 "Build complete! Summary:"
   - Lists all files created/modified
   - Shows total cost ($X.XX)
   - Provides next steps for testing
   - Shows how to access the feature

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
