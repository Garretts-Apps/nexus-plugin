# Cost Report Skill

**Triggers:** "cost report", "show costs", "budget status", "spending", "burn rate"

**Description:** Comprehensive cost analysis and budget tracking.

**Behavior:**

When user requests cost information, this skill narrates the analysis:

0. **Environment Setup**
   - 📢 "Connecting to NEXUS cost tracking database..."
   - 📢 "Loading cost data from isolated VM..."

1. **Data Collection**
   - 📢 "Retrieving current period statistics..."
   - 📢 "Calculating hourly burn rate..."
   - 📢 "Aggregating daily, weekly, and monthly totals..."

2. **Budget Analysis**
   - 📢 "Comparing actual vs target spending..."
   - 📢 "Checking hourly hard cap status..."
   - 📢 "Projecting monthly budget trajectory..."
   - 📢 "Calculating days until budget exhaustion..."

3. **Consumer Breakdown**
   - 📢 "Identifying most expensive agents..."
   - 📢 "Analyzing project-level spending..."
   - 📢 "Breaking down costs by operation type..."
   - 📢 "Summarizing model usage (Opus/Sonnet/Haiku)..."

4. **Trend Analysis**
   - 📢 "Computing hour-over-hour trends..."
   - 📢 "Calculating day-over-day changes..."
   - 📢 "Analyzing week-over-week patterns..."
   - 📢 "Forecasting end-of-month total..."

5. **Optimization Insights**
   - 📢 "Generating cost optimization recommendations..."
   - 📢 "Identifying opportunities to use cheaper models..."
   - 📢 "Detecting inefficient operation patterns..."
   - 📢 "Suggesting budget adjustments if needed..."

6. **Report Generation**
   - 📢 "Compiling executive summary..."
   - 📢 "Cost report complete! 💰"

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
