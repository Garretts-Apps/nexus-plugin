# /nexus-cost

**Description:** Display detailed cost report and budget status.

**Usage:**
```
/nexus-cost
/nexus-cost --period today
/nexus-cost --period week
/nexus-cost --period month
```

**Behavior:**

Generates comprehensive cost analysis using the cost-report skill. Includes:

- Current burn rate
- Budget status vs targets
- Top consumers (agents, projects, models)
- Cost trends and forecasts
- Optimization recommendations

**Parameters:**

- `--period <today|week|month>` (optional): Focus on specific time period
- Default: Shows all periods

**Example Output:**

See cost-report skill documentation for full output format.

**Related:**
- Cost tracking database: `~/.nexus/cost.db`
- Budget configuration: Environment variables or config file
- Set budgets: `NEXUS_HOURLY_TARGET`, `NEXUS_HOURLY_CAP`, `NEXUS_MONTHLY_TARGET`
