# Cost Report Skill

**Triggers:** "cost report", "show costs", "budget status", "spending", "burn rate"

**Description:** Comprehensive cost analysis and budget tracking.

**Behavior:**

Reads the cost tracking database and generates executive summary with:

1. **Current Period Stats**
   - Hourly burn rate
   - Total spent today
   - Total spent this week
   - Total spent this month

2. **Budget Status**
   - Hourly target vs actual
   - Hourly hard cap status
   - Monthly target vs actual
   - Days until monthly budget exhausted (at current rate)

3. **Top Consumers**
   - Most expensive agents
   - Most expensive projects
   - Most expensive operations
   - Model usage breakdown

4. **Cost Trends**
   - Hour-over-hour trend
   - Day-over-day trend
   - Week-over-week trend
   - Projected monthly total

5. **Optimization Recommendations**
   - When to use cheaper models
   - Inefficient operations to optimize
   - Budget adjustments needed

**Example Usage:**
```
User: "Show me the cost report"
```

**Output Format:**
```markdown
# 💰 NEXUS Cost Report

## Current Status
- **Hourly Rate:** $X.XX/hr (target: $1.00/hr)
- **Today:** $X.XX
- **This Week:** $X.XX
- **This Month:** $X.XX / $160.00 target
- **Budget Remaining:** $X.XX (Y days at current rate)

## Top Consumers
1. vp_engineering: $X.XX (N operations)
2. senior_engineer: $X.XX (N operations)
3. architect: $X.XX (N operations)

## Model Usage
- Opus: $X.XX (N calls)
- Sonnet: $X.XX (N calls)
- Haiku: $X.XX (N calls)

## Trends
- Hour-over-hour: ↑ +X% / ↓ -X% / → flat
- Day-over-day: ↑ +X% / ↓ -X% / → flat

## Recommendations
- [Optimization suggestions based on patterns]

## Forecast
- Projected monthly total: $X.XX
- On track: ✓ / ⚠️ / ❌
```

**Parameters:** None (reads from cost.db)

**Cost:** ~$0.001 (uses Haiku for report generation)
