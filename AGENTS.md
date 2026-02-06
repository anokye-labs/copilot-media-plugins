# Copilot Media Plugins - Agent Operating Model

**Last Updated:** 2026-02-06  
**Project:** GitHub Copilot Extension for Media Generation & Manipulation

---

## 🎯 Working in GitHub Issue Context

**CRITICAL:** All agent sessions working on this project must be in the context of a specific GitHub issue.

### Issue Context Requirements

When starting work:
1. **Identify the GitHub issue** you're working on (e.g., #8, #15, #24)
2. **Reference the issue** in your session context
3. **Link commits** to the issue using `Closes #X` or `Fixes #X` in commit messages
4. **Update issue status** as work progresses
5. **Comment on the issue** when blocked or needing clarification

### Finding Your Issue

```powershell
# List all open issues
gh issue list --repo anokye-labs/copilot-media-plugins

# List issues by phase
gh issue list --repo anokye-labs/copilot-media-plugins --label phase-1-infrastructure

# List issues by priority
gh issue list --repo anokye-labs/copilot-media-plugins --label priority-critical

# View specific issue
gh issue view <number> --repo anokye-labs/copilot-media-plugins
```

### Issue Hierarchy

- **Epics** (`epic` label) - Phase-level milestones (#1, #7, #14, #34, #35, #36, #37, #38, #39, #40)
- **Tasks** (`task` label) - Individual work items (P0.1-P0.5, P1.1-P1.6, P2.1-P2.19, etc.)

### Commit Message Format

```
<type>(<scope>): <short description>

<detailed description>

Closes #<issue-number>
Part of #<epic-number>
```

**Example:**
```
feat(fal-ai): Add Invoke-FalGenerate.ps1 script

- Implement queue mode with progress monitoring
- Add async mode option
- Include error handling with retry logic
- Add comprehensive help documentation

Closes #17 (P2.3)
Part of #14 (Phase 2 Epic)
```

---

## 🤖 Continuous AI Operating Model

This project follows the **Continuous AI** pattern - a fleet of specialized agents rather than one general-purpose agent. Each agent owns a specific chore, check, or rule.

### Agent Archetypes

#### 1. Doc-Sync Agent
- **Purpose:** Read function docstrings, compare to implementation, detect mismatches
- **Output:** Opens PRs with fixes
- **Trigger:** On commit to main branch
- **Research:** [GitHub Next - Continuous AI](https://github.blog/ai-and-ml/generative-ai/continuous-ai-in-practice-what-developers-can-automate-today-with-agentic-ci/)

#### 2. Report-Generation Agent
- **Purpose:** Summarize daily/weekly activity, highlight bug trends, correlate changes with test failures
- **Output:** Issues or discussion posts with reports
- **Trigger:** Daily/weekly schedule

#### 3. Performance Regression Agent
- **Purpose:** Flag regressions in critical paths
- **Output:** Comments on PRs or creates issues
- **Trigger:** On PR or push to main

#### 4. Semantic Regression Agent
- **Purpose:** Detect regressions in user flows impossible to express as deterministic rules
- **Output:** Creates issues with examples
- **Trigger:** On significant code changes

#### 5. Media Workflow Agent
- **Purpose:** Orchestrate fal.ai generation + ImageSorcery manipulation workflows
- **Output:** Generated media artifacts
- **Trigger:** On user request via Copilot

#### 6. Test-Plugin Agent
- **Purpose:** Validate plugin functionality across scenarios
- **Output:** Test results and coverage reports
- **Trigger:** On PR or scheduled

---

## 🏗️ Actions-First Design

All agents follow the **Actions-first design pattern**:

### Structure
```yaml
---
on: [trigger]
permissions: read
safe-outputs:
  create-issue:
    title-prefix: "[agent-name] "
---
Plain-language instructions telling the agent what to do.
The agent has access to repository context and can create issues/PRs.
```

### Compilation
```bash
gh aw compile agent-name
```

This generates a standard GitHub Actions YAML file.

### Key Principles
- **Read-only by default** - Write operations gated via safe-output processing
- **PRs as primary output** - Agents don't make autonomous commits
- **Containerized execution** - Reproducibility and safety
- **Transparent logs** - All runs visible in standard Actions logs

---

## 🔄 Error Handling Patterns

### Exponential Backoff with Jitter

For all transient errors (429 rate limits, network timeouts, 503 unavailability):

```
Delay = min(MAX_DELAY, BASE_DELAY * 2^(attempt - 1)) ± jitter

Where:
- BASE_DELAY = 1 second
- MAX_DELAY = 30-60 seconds
- jitter = ±25% randomization
- Max attempts = 3-5
```

**Example sequence:** 1s → 2s → 4s → 8s (with ±25% variance each time)

### Circuit Breaker

When a downstream service is consistently failing:

- **Closed** - Requests pass through; failures counted
- **Open** - Requests immediately rejected; service gets breathing room
- **Half-open** - After timeout, single test request allowed

### Error Classification

| Error Type | Examples | Strategy |
|------------|----------|----------|
| **Transient** | 429 rate limits, timeouts, 503 | Retry with exponential backoff |
| **Permanent** | 401 invalid API key, 400 malformed, 404 not found | Log, alert, fail fast - don't retry |
| **Logical** | Valid but wrong output, infinite loops | Circuit breaker + human escalation |

### Additional Patterns

- **Idempotency** - Every step safely re-runnable; use idempotency keys
- **Correlation IDs** - Single ID across all workflow steps for traceability
- **Human escalation** - Escalate when confidence low or operation destructive
- **Checkpointing** - Persist state at each step; partial failures don't restart entire workflow

---

## 📊 Queue Management

Agents use task queues for probabilistic decision points and tool volatility.

### Essential Queue Features

#### Priority Levels
- **High** - User-facing work (drain first)
- **Normal** - Background processing
- **Low** - Nice-to-have operations

#### Rate-Limit Tracking
Monitor both:
- Request count per minute
- Token usage per minute

Prevents cascading 429 errors.

#### Context Carriage
Each queued task stores:
- Full conversation history
- Original request
- Intermediate results
- Retry metadata

**Why:** Context loss is the most expensive failure. Rebuilding context costs tokens and time, and may produce inconsistent decisions.

#### Deduplication
Hash context before enqueueing to avoid duplicate LLM calls.

#### Dead-Letter Queue (DLQ)
Tasks that exhaust retries land here with:
- Full payload preserved
- Failure reason
- Execution history

**Use DLQ for debugging:** If 10 tasks fail with "context too large", that signals need for better context pruning.

---

## 📈 Monitoring & Observability

### Five Pillars (Azure Agent Factory Model)

1. **Continuous Monitoring**
   - Track actions, decisions, interactions in real time
   - Surface anomalies and performance drift

2. **Tracing**
   - Capture execution flows including reasoning steps
   - Track tool selection and agent collaboration
   - Answer "why and how" not just "what"

3. **Logging**
   - Record decisions, tool calls, state changes
   - Use structured logging with correlation IDs

4. **Evaluation**
   - Assess outputs for quality, safety, compliance
   - Check alignment with user intent

5. **Governance**
   - Enforce policies for ethical, safe, regulatory operation

### Implementation Practices

#### Use OpenTelemetry
Adopt OpenTelemetry for metrics, logs, and traces - data stays portable across Datadog, Grafana, Langfuse, etc.

#### Tag Agent-Specific Metadata
Every log entry includes:
- Model version
- Token count
- Tool used
- Agent ID
- Session ID

#### Trace Multi-Agent Workflows
Capture:
- Every handoff between agents
- Every retry attempt
- Every branch decision

#### Log Prompts, Responses, Tool Calls
For replay and regression detection.

#### Add Monitoring to CI/CD
Catch drift or broken prompts before production.

#### Real-Time Alerts
Integrate with Slack or PagerDuty for immediate notification.

#### Test Observability in Staging
Validate telemetry, alerts, and dashboards under realistic synthetic workloads.

### Structured Log Entry Format

Per agent step:
```json
{
  "timestamp": "2026-02-06T18:42:00Z",
  "trace_id": "abc123",
  "agent_id": "media-workflow-agent",
  "step_name": "generate-image",
  "tool_call": {
    "name": "Invoke-FalGenerate",
    "inputs": {"model": "fal-ai/flux-pro", "prompt": "..."},
    "outputs": {"image_url": "..."}
  },
  "token_count": 250,
  "model_version": "claude-3-opus-20240229",
  "latency_ms": 1500,
  "retry_count": 0,
  "status": "success",
  "reasoning": "Selected flux-pro for high quality requirement"
}
```

### Silent Failure Detection

Watch specifically for:
- **Infinite loops** - Same tool called repeatedly with no progress
- **Context abandonment** - Agent forgets original goal mid-task
- **Drift** - Gradual degradation in output quality over time
- **Runaway costs** - Token usage spiraling from repetitive behavior

---

## 🔒 Reliability Principles

### Read-Only by Default
All agents operate in read-only mode unless explicitly granted write permissions via safe-output processing.

### Pull Requests as Primary Output
Agents create PRs for human review rather than autonomous commits. This ensures:
- Human oversight on all changes
- Diff-based review
- Rollback capability
- Audit trail

### Containerized Execution
All agents run in isolated containers for:
- Reproducibility
- Security isolation
- Consistent environment
- Easy rollback

### Transparent Logs
Nothing is hidden - all runs visible in standard GitHub Actions logs. No black boxes.

### Debuggability Over Complexity
When in doubt, choose the approach that is:
- More transparent
- More auditable
- More diff-based
- Easier to debug

---

## 🎓 Research Backing

All patterns in this document are backed by research:

- **Research #1:** Image Manipulation Techniques (~6,000 words)
- **Research #2:** Claude Plugin/Skill Best Practices (~8,000 words)
- **Research #3:** GitHub Copilot Plugin Architecture (~5,000 words)
- **Research #4:** Agentic AI Workflows & CI/CD (~6,000 words)

**Total Research:** ~25,000 words synthesized

See `docs/RESEARCH_INSIGHTS.md` for complete research findings.

---

## 📚 Project Resources

### Planning Documentation
- **planning/overview.md** - Project mission and scope
- **planning/phases.md** - 10 phases with 100+ tasks
- **planning/dependencies.md** - Dependency matrix
- **planning/technical-decisions.md** - 30+ key decisions

### GitHub Issues
- **Epics:** https://github.com/anokye-labs/copilot-media-plugins/labels/epic
- **All Issues:** https://github.com/anokye-labs/copilot-media-plugins/issues
- **Phase 1 Tasks:** https://github.com/anokye-labs/copilot-media-plugins/labels/phase-1-infrastructure

### Commands
```powershell
# View current phase tasks
gh issue list --repo anokye-labs/copilot-media-plugins --label phase-1-infrastructure --state open

# View critical path items
gh issue list --repo anokye-labs/copilot-media-plugins --label priority-critical --state open

# View your assigned issues
gh issue list --repo anokye-labs/copilot-media-plugins --assignee @me

# Comment on issue
gh issue comment <number> --repo anokye-labs/copilot-media-plugins --body "..."

# Close issue
gh issue close <number> --repo anokye-labs/copilot-media-plugins --comment "Completed in commit <sha>"
```

---

## 🚀 Getting Started

1. **Review planning docs** in `planning/` folder
2. **Find your issue** using gh CLI
3. **Reference issue** in your session
4. **Follow error handling patterns** documented above
5. **Use structured logging** for all operations
6. **Create PRs** not direct commits
7. **Link PRs to issues** with `Closes #X`

---

**Status:** Active Development  
**Current Phase:** Phase 1 - Core Plugin Infrastructure  
**Issues Created:** 40+ (Epics + Tasks)  
**Phase 0:** ✅ Complete (commit ff0f887)
