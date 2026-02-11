# Contributing to Copilot Media Plugins

Thank you for your interest in contributing! This document explains how to get started.

## Reporting Issues

- Use [GitHub Issues](https://github.com/anokye-labs/copilot-media-plugins/issues) to report bugs or request features.
- Check existing issues before creating a new one to avoid duplicates.
- Use the provided issue templates (bug report, feature request) when available.
- Include steps to reproduce, expected behavior, and actual behavior for bug reports.

## Submitting Pull Requests

1. **Fork** the repository and create a branch from `main`.
2. **Name your branch** using the convention: `<type>/<short-description>` (e.g., `feat/add-blur-script`, `fix/queue-timeout`, `docs/update-readme`).
3. **Make your changes** — keep PRs focused on a single concern.
4. **Write or update tests** for any new functionality.
5. **Run tests** before submitting (see [Testing](#testing)).
6. **Open a PR** against `main` and fill out the PR template.
7. **Link issues** using `Closes #<number>` in the PR description.

### Commit Message Format

```
<type>(<scope>): <short description>

<optional body>

Closes #<issue-number>
```

**Types:** `feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `ci`

**Example:**
```
feat(fal-ai): add image-to-video generation script

Implement Invoke-FalImageToVideo.ps1 with queue mode support
and progress monitoring.

Closes #25
```

## Development Setup

### Prerequisites

- **PowerShell 7+** — [Install guide](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell)
- **fal.ai API key** — [Get one at fal.ai](https://fal.ai/dashboard/keys)
- **Python 3.10+** — For ImageSorcery MCP server (optional)
- **Pester 5** — PowerShell testing framework

### Getting Started

```powershell
# Clone the repository
git clone https://github.com/anokye-labs/copilot-media-plugins.git
cd copilot-media-plugins

# Set your API key
$env:FAL_KEY = "your-key-here"

# Install Pester (if not already installed)
Install-Module -Name Pester -MinimumVersion 5.0 -Scope CurrentUser -Force

# Verify setup
.\scripts\Test-FalConnection.ps1
```

### Project Structure

```
copilot-media-plugins/
├── scripts/          # PowerShell scripts and shared module
│   ├── FalAi.psm1   # Shared module (auth, HTTP, uploads, queue)
│   └── *.ps1         # Individual command scripts
├── skills/           # Copilot skill definitions
│   ├── fal-ai/       # AI generation skill
│   ├── image-sorcery/ # Local image processing skill
│   └── media-agents/ # Multi-step workflow skill
├── tests/            # Test suites
│   ├── unit/         # Unit tests
│   ├── integration/  # Integration tests
│   ├── e2e/          # End-to-end tests
│   ├── evaluation/   # Quality evaluation tests
│   └── gates/        # Quality gate checks
├── docs/             # Documentation
└── .github/          # GitHub configuration
```

## Testing

This project uses [Pester 5](https://pester.dev/) for testing.

```powershell
# Run all tests
Invoke-Pester -Path tests/

# Run a specific tier
Invoke-Pester -Path tests/unit/
Invoke-Pester -Path tests/integration/

# Run with detailed output
Invoke-Pester -Path tests/ -Output Detailed
```

### Writing Tests

- Place tests alongside the tier they belong to (`tests/unit/`, `tests/integration/`, etc.).
- Name test files `*.Tests.ps1` following Pester conventions.
- Use `Describe`, `Context`, and `It` blocks for structure.
- Mock external API calls in unit tests using `Mock`.

## Code Style

### PowerShell Best Practices

- Use **approved verbs** for function/script names (`Get-`, `Set-`, `Invoke-`, `Test-`, `New-`, `Measure-`).
- Include **comment-based help** (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`) in all scripts and exported functions.
- Use `[CmdletBinding()]` and `[Parameter()]` attributes for all parameters.
- Use `[OutputType()]` to declare return types.
- Follow the existing patterns in `scripts/` — import `FalAi.psm1` for shared functionality.
- Prefer `Write-Verbose` and `Write-Warning` over `Write-Host` for diagnostic output.
- Use `ErrorAction Stop` in `try/catch` blocks for explicit error handling.

### General Guidelines

- Keep functions focused — one function, one responsibility.
- Avoid hardcoded values — use parameters or module-level constants.
- Document non-obvious logic with inline comments.

## Branch Naming Conventions

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feat/` | New feature | `feat/add-video-gen` |
| `fix/` | Bug fix | `fix/queue-timeout` |
| `docs/` | Documentation | `docs/update-api-ref` |
| `test/` | Test changes | `test/add-unit-tests` |
| `refactor/` | Code refactoring | `refactor/simplify-auth` |
| `chore/` | Maintenance tasks | `chore/update-deps` |
| `ci/` | CI/CD changes | `ci/add-lint-workflow` |

## Questions?

Open a [discussion](https://github.com/anokye-labs/copilot-media-plugins/discussions) or file an issue if you have questions about contributing.
