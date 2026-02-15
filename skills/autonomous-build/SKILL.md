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
   - 📢 "Determining if specialized agents are needed..."
   - Shows the technical plan to user

2.5. **Dynamic Team Building** (if needed)
   - 📢 "Hiring Frontend Engineer for UI components..." (if frontend work needed)
   - 📢 "Hiring Security Engineer for authentication..." (if security work needed)
   - 📢 "Hiring Database Architect for schema design..." (if database work needed)
   - 📢 "Hiring Performance Engineer for optimization..." (if performance critical)
   - **Hired agents persist for entire session**
   - Available agents: Frontend/Backend Engineers, Architects, Security Engineers, Performance Engineers, Designers, DevOps Engineers
   - VP decides who to hire based on task requirements

3. **Implementation Phase** (Senior Engineers + Hired Specialists)
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
User: "Build me a user authentication API with React frontend"
```

**What happens:**
1. VP Engineering analyzes the requirements
2. VP decides to hire:
   - 📢 "Hiring Security Engineer for auth implementation..."
   - 📢 "Hiring Frontend Engineer for React UI..."
3. Team (VP + Senior Engineer + Security Engineer + Frontend Engineer) implements:
   - Backend API with JWT auth (Security Engineer)
   - React login/signup components (Frontend Engineer)
   - Database schema (Senior Engineer)
   - Integration and testing (QA Lead)
4. **Hired agents stay available for the rest of the session** - so follow-up requests like "Add password reset" can use the same Security Engineer

The skill autonomously plans, hires specialists, implements, tests, and commits a complete system.

**Parameters:**
- User provides high-level description
- All implementation details determined autonomously
- No follow-up questions unless requirements are ambiguous
- VP autonomously decides which specialists to hire

**Dynamic Team Building:**
- VP Engineering analyzes task requirements
- Hires specialists as needed from available agent pool:
  - Frontend Engineer (React, Vue, Angular, UI/UX)
  - Backend Engineer (APIs, databases, microservices)
  - Security Engineer (auth, encryption, vulnerabilities)
  - Performance Engineer (optimization, caching, scaling)
  - Database Architect (schema design, migrations, queries)
  - DevOps Engineer (CI/CD, Docker, Kubernetes)
  - Designer (UI design, prototyping, accessibility)
- **Session Persistence**: Hired agents remain available for follow-up requests
- Use `/nexus-status` to see current team composition
- Use `/nexus-hire <role>` to manually add specialists

**Output:**
- Working code committed to Git
- Cost report (including hired agents' costs)
- Quality assessment
- Team roster (who did what)
- Ready-to-test implementation
