# Copilot Media Plugins

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![PowerShell 7+](https://img.shields.io/badge/PowerShell-7%2B-5391FE?logo=powershell&logoColor=white)](https://github.com/PowerShell/PowerShell)
[![fal.ai](https://img.shields.io/badge/fal.ai-API-FF6B35)](https://fal.ai)

A **GitHub Copilot Extension** for generating and manipulating media using [fal.ai](https://fal.ai) AI models and [ImageSorcery](https://github.com/TheCompAce/image-sorcery-mcp) MCP. Generate images, videos, and audio from text prompts — then crop, resize, annotate, detect objects, and more — all from within Copilot.

## Key Features

- **AI Media Generation** — Text-to-image, text-to-video, image-to-video via fal.ai models (Flux, Kling, Veo, and more)
- **Local Image Processing** — Crop, resize, rotate, blur, overlay, annotate, OCR, and object detection via ImageSorcery MCP
- **Multi-Step Workflows** — Fleet-pattern agents orchestrate complex pipelines: generate → process → validate → deliver
- **Queue Management** — Async job submission with polling for long-running video generation
- **CDN Upload** — Upload local files to fal.ai CDN for use as model inputs
- **Quality Measurement** — Built-in scripts for image/video quality and API performance metrics

## Quick Start

### Prerequisites

- **PowerShell 7+** — [Install](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell)
- **fal.ai API key** — [Get one at fal.ai](https://fal.ai/dashboard/keys)
- **Python 3.10+** — Required for ImageSorcery MCP server (optional)

### Setup

```powershell
# 1. Clone the repository
git clone https://github.com/anokye-labs/copilot-media-plugins.git
cd copilot-media-plugins

# 2. Set your fal.ai API key
$env:FAL_KEY = "your-key-here"
# Or create a .env file:
"FAL_KEY=your-key-here" | Set-Content .env

# 3. Test connectivity
.\scripts\Test-FalConnection.ps1

# 4. Generate your first image
.\scripts\Invoke-FalGenerate.ps1 -Prompt "A serene mountain landscape"
```

### ImageSorcery Setup (Optional)

```powershell
# Install ImageSorcery MCP server
pip install image-sorcery

# The .mcp.json at the repo root configures the server automatically
```

## Architecture

The extension is organized into **three skills**, a **shared module**, and **fleet-pattern agents**:

```
┌──────────────────────────────────────────────────┐
│                  Copilot Chat                    │
│            (User Request / Prompt)               │
└──────────────┬───────────────────────────────────┘
               │
       ┌───────▼────────┐
       │  Skill Router   │
       └──┬─────┬─────┬──┘
          │     │     │
    ┌─────▼──┐ ┌▼─────▼──┐ ┌──────────┐
    │ fal-ai │ │ image-   │ │  media-  │
    │ skill  │ │ sorcery  │ │  agents  │
    └───┬────┘ └────┬─────┘ └────┬─────┘
        │           │            │
  ┌─────▼─────┐ ┌──▼──────┐ ┌───▼──────────┐
  │ FalAi.psm1│ │   MCP   │ │ Fleet Pattern│
  │ (shared)  │ │ Server  │ │ Orchestrator │
  └─────┬─────┘ └──┬──────┘ └───┬──────────┘
        │           │            │
  ┌─────▼─────┐ ┌──▼──────┐    │
  │  fal.ai   │ │ OpenCV  │    │
  │  Cloud    │ │ YOLO    │    │
  │  API      │ │ EasyOCR │    │
  └───────────┘ └─────────┘    │
        ▲                      │
        └──────────────────────┘
```

| Skill | Purpose | Tools |
|-------|---------|-------|
| **fal-ai** | AI media generation (images, video, audio) | PowerShell scripts → fal.ai REST API |
| **image-sorcery** | Local image processing and analysis | MCP server → OpenCV, YOLO, EasyOCR |
| **media-agents** | Multi-step workflow orchestration | Fleet patterns coordinating both skills |

## Available Scripts

| Script | Description |
|--------|-------------|
| `Invoke-FalGenerate.ps1` | Generate images/videos from text prompts |
| `Invoke-FalImageToVideo.ps1` | Convert images to video with AI |
| `Invoke-FalInpainting.ps1` | AI-powered image inpainting |
| `Invoke-FalUpscale.ps1` | Upscale images with AI models |
| `Invoke-FalVideoGen.ps1` | Text-to-video generation |
| `Get-FalModel.ps1` | Get model info and OpenAPI schema |
| `Get-FalUsage.ps1` | Check API usage and billing |
| `Get-ModelSchema.ps1` | Retrieve model input/output schema |
| `Get-QueueStatus.ps1` | Check queue job status |
| `Search-FalModels.ps1` | Search the fal.ai model catalog |
| `Test-FalConnection.ps1` | Verify API key and connectivity |
| `Test-ImageSorcery.ps1` | Verify ImageSorcery MCP connection |
| `Upload-ToFalCDN.ps1` | Upload files to fal.ai CDN |
| `New-FalWorkflow.ps1` | Create multi-step generation workflows |
| `Measure-ImageQuality.ps1` | Evaluate generated image quality |
| `Measure-VideoQuality.ps1` | Evaluate generated video quality |
| `Measure-ApiPerformance.ps1` | Benchmark API response times |
| `Measure-ApiCost.ps1` | Estimate API call costs |
| `Measure-TokenBudget.ps1` | Track token usage budgets |
| `FalAi.psm1` | Shared module (auth, HTTP, uploads, queue) |

## Documentation

| Resource | Description |
|----------|-------------|
| [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) | System architecture and design |
| [`docs/api-reference/`](docs/api-reference/) | API reference documentation |
| [`docs/user-guides/`](docs/user-guides/) | How-to guides and tutorials |
| [`docs/examples-gallery/`](docs/examples-gallery/) | Example workflows and outputs |
| [`docs/security/`](docs/security/) | Security practices and key management |
| [`docs/ci-cd/`](docs/ci-cd/) | CI/CD pipeline documentation |
| [`skills/fal-ai/SKILL.md`](skills/fal-ai/SKILL.md) | fal.ai skill reference |
| [`skills/image-sorcery/SKILL.md`](skills/image-sorcery/SKILL.md) | ImageSorcery skill reference |
| [`skills/media-agents/SKILL.md`](skills/media-agents/SKILL.md) | Media agents workflow patterns |

## Testing

Tests use [Pester 5](https://pester.dev/) and are organized by tier:

```powershell
# Run all tests
Invoke-Pester -Path tests/

# Run by tier
Invoke-Pester -Path tests/unit/
Invoke-Pester -Path tests/integration/
Invoke-Pester -Path tests/e2e/

# Run quality gates
Invoke-Pester -Path tests/gates/
```

See [`tests/`](tests/) for test fixtures, helpers, and evaluation scripts.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on reporting issues, submitting pull requests, development setup, and code style.

## Security

See [SECURITY.md](SECURITY.md) for vulnerability reporting and security practices.

## License

This project is licensed under the [MIT License](LICENSE).
