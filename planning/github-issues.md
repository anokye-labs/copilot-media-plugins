# GitHub Issues Strategy - Copilot Media Plugins

This document defines the strategy for creating GitHub issues with proper parent-child and blocking relationships from the task dependency graph.

---

## Issue Creation Approach

### Epic → Feature → Task Hierarchy

```
Epic (Phase)
├── Feature (Major Component)
│   ├── Task (Individual Work Item)
│   ├── Task
│   └── Task
└── Feature
    ├── Task
    └── Task
```

**GitHub Limitations:**
- GitHub doesn't have native "Epic" issue type
- Solution: Use labels and issue references

**Our Approach:**
- **Epics:** Issues with `epic` label + `phase-N` label
- **Features:** Issues with `feature` label
- **Tasks:** Regular issues with `task` label
- **Dependencies:** Use "blocked by #X" in description and GitHub task lists

---

## Label System

### Type Labels
- `epic` - Phase-level milestone
- `feature` - Major component (skill, agent, documentation)
- `task` - Individual work item
- `bug` - Issues found during implementation
- `documentation` - Documentation tasks

### Phase Labels
- `phase-0-setup`
- `phase-1-infrastructure`
- `phase-2-fal-ai`
- `phase-3-workflow`
- `phase-4-imagesorcery`
- `phase-5-agents`
- `phase-6-testing`
- `phase-7-documentation`
- `phase-8-github-setup`
- `phase-9-validation`

### Priority Labels
- `priority-critical` - On critical path
- `priority-high` - Blocks multiple tasks
- `priority-medium` - Standard priority
- `priority-low` - Nice to have

### Status Labels
- `status-blocked` - Waiting on dependencies
- `status-in-progress` - Currently being worked on
- `status-ready` - Dependencies met, ready to start
- `status-review` - In code review

### Special Labels
- `good-first-issue` - Great for newcomers
- `help-wanted` - Community contributions welcome
- `research-backed` - Based on research findings

---

## Issue Template Structure

### Epic Issue Template

```markdown
## Epic: [Phase Name]

**Phase:** [Phase Number]  
**Estimated Duration:** [X-Y days]  
**Dependencies:** [Previous Phase Epic]

### Overview
[Brief description of phase goals]

### Features Included
- [ ] #[feature-issue-1] - [Feature Name]
- [ ] #[feature-issue-2] - [Feature Name]
- [ ] #[feature-issue-3] - [Feature Name]

### Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

### Dependencies
**Blocked By:**
- #[previous-epic-issue]

**Blocks:**
- #[next-epic-issue]

### Related Documentation
- [phases.md](../planning/phases.md#phase-N)
- [dependencies.md](../planning/dependencies.md)

---
**Labels:** `epic`, `phase-N-[name]`, `priority-[level]`
```

### Feature Issue Template

```markdown
## Feature: [Feature Name]

**Epic:** #[epic-issue]  
**Phase:** [Phase Number]  
**Estimated Effort:** [hours/days]

### Description
[What this feature accomplishes]

### Tasks
- [ ] #[task-issue-1] - [Task Name]
- [ ] #[task-issue-2] - [Task Name]
- [ ] #[task-issue-3] - [Task Name]

### Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]

### Dependencies
**Blocked By:**
- #[dependency-issue-1]
- #[dependency-issue-2]

**Blocks:**
- #[blocked-issue-1]
- #[blocked-issue-2]

### Research Foundation
[Reference to research insights if applicable]

### Acceptance Criteria
- [ ] Code written and reviewed
- [ ] Tests passing
- [ ] Documentation updated

---
**Labels:** `feature`, `phase-N-[name]`, `priority-[level]`
```

### Task Issue Template

```markdown
## Task: [Task Name]

**Feature:** #[feature-issue]  
**Epic:** #[epic-issue]  
**Task ID:** [P#.#]  
**Estimated Effort:** [hours]

### Description
[Detailed description of what needs to be done]

### Implementation Details
[Specific steps or technical details]

### Files to Create/Modify
- `path/to/file1.ext`
- `path/to/file2.ext`

### Success Criteria
- [ ] [Specific completion criterion 1]
- [ ] [Specific completion criterion 2]

### Dependencies
**Blocked By:**
- #[dependency-task] ([Task ID])

**Blocks:**
- #[blocked-task] ([Task ID])

### Research Reference
[Link to relevant research section if applicable]

### Testing
- [ ] Unit tests added/updated
- [ ] Integration tests passing
- [ ] Manual testing completed

---
**Labels:** `task`, `phase-N-[name]`, `priority-[level]`
```

---

## Issue Creation Order

### Phase 1: Create All Epics
Create 10 Epic issues (one per phase) in order:

1. Epic: Phase 0 - Setup & Initial Structure
2. Epic: Phase 1 - Core Plugin Infrastructure
3. Epic: Phase 2 - fal.ai Integration
4. Epic: Phase 3 - Workflow Builder Skill
5. Epic: Phase 4 - ImageSorcery Integration
6. Epic: Phase 5 - Agentic Capabilities
7. Epic: Phase 6 - Testing Infrastructure
8. Epic: Phase 7 - Documentation & Best Practices
9. Epic: Phase 8 - GitHub Repository Setup
10. Epic: Phase 9 - Validation & Polish

**Link them sequentially:**
- Epic 1 blocks Epic 2
- Epic 2 blocks Epic 3
- ... and so on

### Phase 2: Create Feature Issues
For each Epic, create Feature issues:

**Example for Phase 2 Epic:**
- Feature: fal.ai Core Skill Definition
- Feature: PowerShell Script Conversions
- Feature: fal.ai Reference Documentation

### Phase 3: Create Task Issues
For each Feature, create Task issues with proper dependencies.

**Example for "PowerShell Script Conversions" Feature:**
- Task: P2.3 - Convert generate.sh to Invoke-FalGenerate.ps1
- Task: P2.4 - Convert search-models.sh to Search-FalModels.ps1
- ... etc.

---

## Detailed Issue List by Phase

### Phase 0: Setup & Initial Structure

#### Epic Issue
**Title:** Epic: Phase 0 - Setup & Initial Structure  
**Number:** #1  
**Labels:** `epic`, `phase-0-setup`, `priority-critical`

#### Feature Issues
1. **Feature: Project Initialization** (#2)
   - Task: P0.1 - Rename folder (#3)
   - Task: P0.2 - Initialize git repository (#4)
   - Task: P0.3 - Create folder structure (#5)
   - Task: P0.4 - Create .gitignore (#6)
   - Task: P0.5 - Document research insights (#7)

---

### Phase 1: Core Plugin Infrastructure

#### Epic Issue
**Title:** Epic: Phase 1 - Core Plugin Infrastructure  
**Number:** #8  
**Labels:** `epic`, `phase-1-infrastructure`, `priority-critical`  
**Blocked By:** #1

#### Feature Issues
1. **Feature: Plugin Configuration Files** (#9)
   - Task: P1.1 - Create .mcp.json (#10)
   - Task: P1.2 - Draft README.md (#11)
   - Task: P1.3 - Create LICENSE (#12)
   - Task: P1.4 - Create CONTRIBUTING.md (#13)

2. **Feature: Repository Documentation** (#14)
   - Task: P1.5 - Create copilot-instructions.md (#15)
   - Task: P1.6 - Document architecture (#16)

---

### Phase 2: fal.ai Integration

#### Epic Issue
**Title:** Epic: Phase 2 - fal.ai Integration  
**Number:** #17  
**Labels:** `epic`, `phase-2-fal-ai`, `priority-critical`  
**Blocked By:** #16 (P1.6)

#### Feature Issues
1. **Feature: Script Analysis** (#18)
   - Task: P2.1 - Analyze existing scripts (#19)

2. **Feature: fal.ai Core Skill** (#20)
   - Task: P2.2 - Create SKILL.md (#21)

3. **Feature: PowerShell Scripts** (#22)
   - Task: P2.3 - Invoke-FalGenerate.ps1 (#23)
   - Task: P2.4 - Search-FalModels.ps1 (#24)
   - Task: P2.5 - Get-ModelSchema.ps1 (#25)
   - Task: P2.6 - Get-QueueStatus.ps1 (#26)
   - Task: P2.7 - Upload-ToFalCDN.ps1 (#27)
   - Task: P2.8 - New-FalWorkflow.ps1 (#28)

4. **Feature: Reference Documentation** (#29)
   - Task: P2.9 - MODELS.md (#30)
   - Task: P2.10 - WORKFLOWS.md (#31)
   - Task: P2.11 - PLATFORM.md (#32)
   - Task: P2.12 - EXAMPLES.md (#33)
   - Task: P2.13 - API.md (#34)

---

### Phase 3: Workflow Builder Skill

#### Epic Issue
**Title:** Epic: Phase 3 - Workflow Builder Skill  
**Number:** #35  
**Labels:** `epic`, `phase-3-workflow`, `priority-critical`  
**Blocked By:** #34 (P2.13)

#### Feature Issues
1. **Feature: Workflow Skill** (#36)
   - Task: P3.1 - Adapt fal-workflow skill (#37)
   - Task: P3.5 - Create New-Workflow.ps1 (#42)

2. **Feature: Workflow References** (#38)
   - Task: P3.2 - NODE_TYPES.md (#39)
   - Task: P3.3 - PATTERNS.md (#40)
   - Task: P3.4 - TROUBLESHOOTING.md (#41)

---

### Phase 4: ImageSorcery Integration

#### Epic Issue
**Title:** Epic: Phase 4 - ImageSorcery Integration  
**Number:** #43  
**Labels:** `epic`, `phase-4-imagesorcery`, `priority-critical`  
**Blocked By:** #10 (P1.1), #42 (P3.5)

#### Feature Issues
1. **Feature: MCP Configuration** (#44)
   - Task: P4.1 - Configure .mcp.json (#45)

2. **Feature: ImageSorcery Skill** (#46)
   - Task: P4.2 - Create SKILL.md (#47)
   - Task: P4.9 - Test-ImageSorcery.ps1 (#56)

3. **Feature: Tiered Image Operations** (#48)
   - Task: P4.3 - TIER1_OPERATIONS.md (#49)
   - Task: P4.4 - TIER2_OPERATIONS.md (#50)
   - Task: P4.5 - TIER3_OPERATIONS.md (#51)
   - Task: P4.6 - TIER4_OPERATIONS.md (#52)
   - Task: P4.7 - WORKFLOWS.md (#53)
   - Task: P4.8 - EXAMPLES.md (#54)

---

### Phase 5: Agentic Capabilities

#### Epic Issue
**Title:** Epic: Phase 5 - Agentic Capabilities  
**Number:** #57  
**Labels:** `epic`, `phase-5-agents`, `priority-critical`  
**Blocked By:** #56 (P4.9)

#### Feature Issues
1. **Feature: Media Agents Skill** (#58)
   - Task: P5.1 - Create SKILL.md (#59)

2. **Feature: Agent References** (#60)
   - Task: P5.2 - AGENT_PATTERNS.md (#61)
   - Task: P5.3 - RELIABILITY.md (#62)
   - Task: P5.4 - GITHUB_ACTIONS.md (#63)
   - Task: P5.5 - QUEUE_MANAGEMENT.md (#64)
   - Task: P5.6 - MONITORING.md (#65)

3. **Feature: GitHub Actions Agents** (#66)
   - Task: P5.7 - doc-sync-agent.yml (#67)
   - Task: P5.8 - test-plugin.yml (#68)
   - Task: P5.9 - media-workflow-agent.yml (#69)
   - Task: P5.10 - performance-check.yml (#70)

4. **Feature: Agent Documentation** (#71)
   - Task: P5.11 - Update copilot-instructions (#72)
   - Task: P5.12 - AGENT_DESIGN.md (#73)

---

### Phase 6: Testing Infrastructure

#### Epic Issue
**Title:** Epic: Phase 6 - Testing Infrastructure  
**Number:** #74  
**Labels:** `epic`, `phase-6-testing`, `priority-critical`  
**Blocked By:** #73 (P5.12)

#### Feature Issues
1. **Feature: Test Documentation** (#75)
   - Task: P6.1 - tests/README.md (#76)

2. **Feature: Unit Tests** (#77)
   - Task: P6.2 - PowerShell script unit tests (#78)
   - Task: P6.3 - Workflow unit tests (#79)
   - Task: P6.4 - Error handling tests (#80)

3. **Feature: Integration Tests** (#81)
   - Task: P6.5 - fal-ai integration tests (#82)
   - Task: P6.6 - ImageSorcery integration tests (#83)
   - Task: P6.7 - Workflow integration tests (#84)

4. **Feature: E2E Test Scenarios** (#85)
   - Task: P6.8 - fal-ai E2E scenarios (#86)
   - Task: P6.9 - ImageSorcery E2E scenarios (#87)
   - Task: P6.10 - Workflow E2E scenarios (#88)
   - Task: P6.11 - Agent E2E scenarios (#89)

5. **Feature: Test Infrastructure** (#90)
   - Task: P6.15 - Create test fixtures (#91)
   - Task: P6.16 - Test CI workflow (#92)

---

### Phase 7: Documentation & Best Practices

#### Epic Issue
**Title:** Epic: Phase 7 - Documentation & Best Practices  
**Number:** #93  
**Labels:** `epic`, `phase-7-documentation`, `priority-high`  
**Blocked By:** #92 (P6.16)

#### Feature Issues
1. **Feature: Core Documentation** (#94)
   - Task: P7.1 - BEST_PRACTICES.md (#95)
   - Task: P7.2 - TOKEN_OPTIMIZATION.md (#96)
   - Task: P7.3 - QUICK_START.md (#97)
   - Task: P7.4 - TROUBLESHOOTING.md (#98)

2. **Feature: Code Documentation** (#99)
   - Task: P7.5 - Add script documentation (#100)
   - Task: P7.6 - Review trigger phrases (#101)

---

### Phase 8: GitHub Repository Setup

#### Epic Issue
**Title:** Epic: Phase 8 - GitHub Repository Setup  
**Number:** #102  
**Labels:** `epic`, `phase-8-github-setup`, `priority-critical`  
**Blocked By:** #101 (P7.6)

#### Feature Issues
1. **Feature: Repository Creation** (#103)
   - Task: P8.1 - Create repository (#104)
   - Task: P8.2 - Configure repository (#105)
   - Task: P8.3 - Push initial commit (#106)

2. **Feature: Initial Release** (#107)
   - Task: P8.4 - Create initial release (#108)
   - Task: P8.5 - Update README installation (#109)

---

### Phase 9: Validation & Polish

#### Epic Issue
**Title:** Epic: Phase 9 - Validation & Polish  
**Number:** #110  
**Labels:** `epic`, `phase-9-validation`, `priority-critical`  
**Blocked By:** #109 (P8.5)

#### Feature Issues
1. **Feature: Test Execution** (#111)
   - Task: P9.1 - Run unit tests (#112)
   - Task: P9.2 - Run integration tests (#113)
   - Task: P9.3 - Execute E2E scenarios (#114)

2. **Feature: Installation Validation** (#115)
   - Task: P9.4 - Test installation (#116)
   - Task: P9.5 - Validate PowerShell scripts (#117)

3. **Feature: Documentation Validation** (#118)
   - Task: P9.6 - Check documentation links (#119)
   - Task: P9.7 - Spell check (#120)

4. **Feature: Configuration Validation** (#121)
   - Task: P9.8 - Validate .mcp.json (#122)
   - Task: P9.9 - Test GitHub Actions (#123)

5. **Feature: Final Review** (#124)
   - Task: P9.10 - Token budget audit (#125)
   - Task: P9.11 - Final code review (#126)
   - Task: P9.12 - Tag final release (#127)

---

## Issue Creation Script (PowerShell)

```powershell
# GitHub CLI script to create all issues with proper relationships
# Requires: gh CLI authenticated

$org = "anokye-labs"
$repo = "copilot-media-plugins"

# Function to create issue and return number
function New-ProjectIssue {
    param(
        [string]$Title,
        [string]$Body,
        [string[]]$Labels,
        [string]$Milestone
    )
    
    $labelArgs = $Labels | ForEach-Object { "--label", $_ }
    $result = gh issue create `
        --repo "$org/$repo" `
        --title "$Title" `
        --body "$Body" `
        @labelArgs `
        $(if ($Milestone) { "--milestone", $Milestone })
    
    # Extract issue number from output
    if ($result -match '#(\d+)') {
        return [int]$Matches[1]
    }
}

# Phase 0 Epic
$epic0 = New-ProjectIssue `
    -Title "Epic: Phase 0 - Setup & Initial Structure" `
    -Body @"
## Overview
Initialize project structure and prepare development environment.

### Features
- [ ] #TBD - Project Initialization

### Success Criteria
- [ ] Folder renamed to copilot-media-plugins
- [ ] Git repository initialized
- [ ] Directory structure created
- [ ] Documentation in place

**Estimated Duration:** 2-4 hours  
**Critical Path:** Yes
"@ `
    -Labels "epic", "phase-0-setup", "priority-critical"

# Continue for all phases...
# See full script in repository
```

---

## Milestones

Create GitHub milestones for tracking:

1. **v0.1.0 - Planning Complete** (current)
2. **v0.2.0 - Infrastructure Ready** (Phase 0-1)
3. **v0.3.0 - Core Skills Complete** (Phase 2-4)
4. **v0.4.0 - Agents Implemented** (Phase 5)
5. **v0.5.0 - Testing Complete** (Phase 6)
6. **v0.9.0 - Documentation Ready** (Phase 7-8)
7. **v1.0.0 - Production Release** (Phase 9)

---

## Project Board Setup

### Columns
1. **📋 Backlog** - Not yet started
2. **🚫 Blocked** - Waiting on dependencies
3. **✅ Ready** - Dependencies met, can start
4. **🔨 In Progress** - Currently being worked on
5. **👀 Review** - In code review
6. **✔️ Done** - Completed

### Automation Rules
- New issues → Backlog
- Issues with `status-blocked` label → Blocked column
- Issues with `status-ready` label → Ready column
- Issues with `status-in-progress` label → In Progress column
- Issues with `status-review` label → Review column
- Closed issues → Done column

---

## Dependency Tracking

### In Issue Body
Use task lists with issue references:

```markdown
### Dependencies
**Blocked By:**
- [ ] #19 - P2.1: Analyze existing scripts
- [ ] #21 - P2.2: Create fal-ai SKILL.md

**Blocks:**
- [ ] #82 - P6.5: fal-ai integration tests
- [ ] #86 - P6.8: fal-ai E2E scenarios
```

### GitHub Features
- **Cross-reference:** Mention issues with `#number` in comments
- **Task lists:** Check off blockers as they complete
- **Labels:** Use `status-blocked` to filter view

---

## Issue Assignment Strategy

### Self-Assignment
- Contributors assign themselves when starting work
- Move issue to "In Progress" column

### Team Assignment
If working with team:
- **Phase 1-2:** Backend/Infrastructure team
- **Phase 3-4:** Integration team
- **Phase 5:** DevOps/Agents team
- **Phase 6:** QA team
- **Phase 7-9:** Everyone (documentation, validation)

---

## Issue Close Criteria

Before closing an issue:
- [ ] All tasks in description checked off
- [ ] Code committed and pushed
- [ ] Tests passing
- [ ] Documentation updated
- [ ] Code reviewed (if applicable)
- [ ] Blocking issues unblocked

---

## Summary

**Total Issues to Create:** ~130
- 10 Epic issues (phases)
- 30-40 Feature issues (components)
- 80-100 Task issues (individual work)

**Creation Order:**
1. Create all Epics (link sequentially)
2. Create all Features (link to Epics)
3. Create all Tasks (link dependencies)

**Estimated Setup Time:** 2-4 hours (automated script recommended)

---

*Last Updated: 2026-02-06*  
*See [phases.md](./phases.md) for detailed phase breakdown*  
*See [dependencies.md](./dependencies.md) for dependency matrix*  
*See [task-graph.md](./task-graph.md) for visual dependency graphs*
