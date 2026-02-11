# Copilot Instructions for copilot-media-plugins

This is a **GitHub Copilot Extension** for media generation and manipulation using fal.ai cloud APIs and ImageSorcery MCP for local image processing.

## Project Overview

- **Purpose:** Generate images, videos, and audio from text prompts via fal.ai, and process/analyze images locally via ImageSorcery MCP.
- **Language:** PowerShell 7+ for all scripts; Python for ImageSorcery MCP server.
- **Architecture:** Three skills (`fal-ai`, `image-sorcery`, `media-agents`) coordinated by fleet-pattern agents.

## Key Conventions

### Shared Module

All scripts use `scripts/FalAi.psm1` as the shared module. It provides:
- `Get-FalApiKey` — Load API key from `$env:FAL_KEY` or `.env`
- `Invoke-FalApi` — HTTP wrapper with auth, retry, error parsing
- `Send-FalFile` — CDN file upload (2-step token flow)
- `Wait-FalJob` — Queue submit → poll → retrieve
- `ConvertTo-FalError` — Extract error messages from fal.ai responses

When creating new scripts, import this module and use its functions instead of reimplementing HTTP logic.

### Skills

Skill definitions are in `skills/*/SKILL.md`:
- `skills/fal-ai/SKILL.md` — AI generation (text-to-image, text-to-video, image-to-video)
- `skills/image-sorcery/SKILL.md` — Local image processing (crop, resize, detect, OCR)
- `skills/media-agents/SKILL.md` — Multi-step workflow orchestration (fleet patterns)

### Script Patterns

Follow existing scripts in `scripts/` when creating new commands:
- Use `#Requires -Version 5.1` at the top
- Include comment-based help (`.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`)
- Use `[CmdletBinding()]` and typed `[Parameter()]` attributes
- Import `FalAi.psm1` with `Import-Module`
- Use `Invoke-FalApi` for API calls, `Wait-FalJob` for queue operations
- Return structured `[PSCustomObject]` results

### Testing

- Tests use **Pester 5** framework
- Test files are in `tests/` organized by tier: `unit/`, `integration/`, `e2e/`, `evaluation/`, `gates/`
- Name test files `*.Tests.ps1`
- Mock external API calls in unit tests
- Run tests with `Invoke-Pester`

### Error Handling

- Retry transient errors (429, 5xx) with exponential backoff (handled by `Invoke-FalApi`)
- Fail fast on permanent errors (401, 400)
- Use `ConvertTo-FalError` to parse fal.ai error responses
- Include meaningful error messages with context

### File Organization

```
scripts/         → PowerShell scripts and FalAi.psm1 shared module
skills/          → Copilot skill definitions (SKILL.md files)
tests/           → Pester 5 test suites
docs/            → Project documentation
.github/         → GitHub workflows, issue templates, PR template
```
