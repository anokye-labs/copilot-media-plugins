# PowerShell Scripts Reference

> **Note:** These scripts are planned for implementation. Parameters and behavior are subject to change as scripts are developed.

## Script Index

| Script | Category | Description |
|--------|----------|-------------|
| [Invoke-FalGenerate](#invoke-falgenerate) | Generation | Text-to-image generation |
| [Invoke-FalUpscale](#invoke-falupscale) | Processing | AI-powered image upscaling |
| [Invoke-FalEditImage](#invoke-faleditimage) | Processing | Image editing (inpainting, outpainting) |
| [Invoke-FalSearchModels](#invoke-falsearchmodels) | Discovery | Search available fal.ai models |
| [Invoke-FalGetSchema](#invoke-falgetschema) | Discovery | Get model input/output schema |
| [Invoke-FalUpload](#invoke-falupload) | Utility | Upload files to fal.ai storage |
| [Invoke-FalSpeechToText](#invoke-falspeechtotext) | Audio | Transcribe audio to text |
| [Invoke-FalTextToSpeech](#invoke-faltexttospeech) | Audio | Generate speech from text |
| [Invoke-FalEstimateCost](#invoke-falestimatecost) | Billing | Estimate cost before execution |
| [Invoke-FalPricing](#invoke-falpricing) | Billing | View model pricing information |
| [Invoke-FalUsage](#invoke-falusage) | Billing | Check account usage and limits |
| [New-FalWorkflow](#new-falworkflow) | Workflow | Define multi-step media workflows |
| [Invoke-FalRequests](#invoke-falrequests) | Utility | List and manage pending requests |

---

## Generation

### Invoke-FalGenerate

Generate images from text prompts using fal.ai models.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Prompt` | string | Yes | — | Text description of the image to generate |
| `-Model` | string | No | `fal-ai/flux/dev` | Model identifier |
| `-Steps` | int | No | 20 | Number of inference steps |
| `-GuidanceScale` | float | No | 7.0 | Prompt adherence (1.0–20.0) |
| `-Seed` | int | No | Random | Seed for reproducibility |
| `-Width` | int | No | 1024 | Output width in pixels |
| `-Height` | int | No | 1024 | Output height in pixels |
| `-NumImages` | int | No | 1 | Number of images to generate |
| `-OutputPath` | string | No | — | Local path to save the image |

**Returns:** Object with `url`, `seed`, `width`, `height`, `model`, `timings`

**Example:**

```powershell
# Basic generation
Invoke-FalGenerate -Prompt "A red fox in a snowy forest"

# With parameters
Invoke-FalGenerate -Prompt "Mountain sunset" -Model "fal-ai/flux-pro" -Steps 30 -Seed 42 -OutputPath "./output/sunset.png"

# Multiple images
Invoke-FalGenerate -Prompt "Abstract art" -NumImages 4
```

---

## Processing

### Invoke-FalUpscale

Upscale images using AI super-resolution models.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-ImagePath` | string | Yes | — | Path to the input image |
| `-ImageUrl` | string | Yes | — | URL of the input image (alternative to `-ImagePath`) |
| `-Scale` | int | No | 2 | Upscale factor (2 or 4) |
| `-Model` | string | No | Auto | Upscaling model to use |
| `-OutputPath` | string | No | — | Local path to save the result |

**Returns:** Object with `url`, `width`, `height`, `scale`, `timings`

**Example:**

```powershell
Invoke-FalUpscale -ImagePath "./input/photo.jpg" -Scale 4 -OutputPath "./output/photo_4x.png"
```

### Invoke-FalEditImage

Edit images using inpainting, outpainting, or style transfer.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-ImagePath` | string | Yes | — | Path to the input image |
| `-Prompt` | string | Yes | — | Description of the edit |
| `-MaskPath` | string | No | — | Path to mask image (for inpainting) |
| `-Mode` | string | No | `inpaint` | Edit mode: `inpaint`, `outpaint`, `style` |
| `-OutputPath` | string | No | — | Local path to save the result |

**Returns:** Object with `url`, `mode`, `timings`

**Example:**

```powershell
Invoke-FalEditImage -ImagePath "./input/photo.jpg" -Prompt "Replace the sky with a sunset" -MaskPath "./masks/sky.png"
```

---

## Discovery

### Invoke-FalSearchModels

Search available models on fal.ai by keyword or category.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Query` | string | No | — | Search keyword |
| `-Category` | string | No | — | Filter by category: `image`, `video`, `audio`, `text` |
| `-Limit` | int | No | 20 | Maximum results to return |

**Returns:** Array of model objects with `id`, `name`, `description`, `category`

**Example:**

```powershell
Invoke-FalSearchModels -Query "upscale" -Category "image"
```

### Invoke-FalGetSchema

Retrieve the input/output schema for a specific model.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Model` | string | Yes | — | Model identifier |

**Returns:** Object with `input_schema`, `output_schema` as JSON schema objects

**Example:**

```powershell
Invoke-FalGetSchema -Model "fal-ai/flux/dev"
```

---

## Utility

### Invoke-FalUpload

Upload a file to fal.ai storage for use in API calls.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-FilePath` | string | Yes | — | Path to the file to upload |
| `-ContentType` | string | No | Auto-detected | MIME type of the file |

**Returns:** Object with `url`, `content_type`, `file_name`

**Example:**

```powershell
$uploaded = Invoke-FalUpload -FilePath "./input/photo.jpg"
Invoke-FalEditImage -ImageUrl $uploaded.url -Prompt "Add a hat"
```

### Invoke-FalRequests

List, check status, or cancel pending fal.ai requests.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Action` | string | No | `list` | Action: `list`, `status`, `cancel` |
| `-RequestId` | string | No | — | Request ID (for `status` or `cancel`) |
| `-Limit` | int | No | 10 | Maximum results for `list` |

**Returns:** Request object(s) with `id`, `status`, `model`, `created_at`

**Example:**

```powershell
# List recent requests
Invoke-FalRequests

# Check status
Invoke-FalRequests -Action status -RequestId "req_abc123"

# Cancel a request
Invoke-FalRequests -Action cancel -RequestId "req_abc123"
```

---

## Audio

### Invoke-FalSpeechToText

Transcribe audio files to text.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-AudioPath` | string | Yes | — | Path to the audio file |
| `-AudioUrl` | string | Yes | — | URL of the audio (alternative to `-AudioPath`) |
| `-Language` | string | No | Auto-detected | Language code (e.g., `en`, `es`, `fr`) |

**Returns:** Object with `text`, `language`, `duration`, `segments`

**Example:**

```powershell
Invoke-FalSpeechToText -AudioPath "./input/recording.mp3"
```

### Invoke-FalTextToSpeech

Generate speech audio from text.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Text` | string | Yes | — | Text to convert to speech |
| `-Voice` | string | No | Default | Voice identifier |
| `-OutputPath` | string | No | — | Local path to save the audio |

**Returns:** Object with `url`, `duration`, `voice`

**Example:**

```powershell
Invoke-FalTextToSpeech -Text "Hello, welcome to our product demo." -OutputPath "./output/welcome.mp3"
```

---

## Billing

### Invoke-FalEstimateCost

Estimate the cost of an operation before executing it.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Model` | string | Yes | — | Model identifier |
| `-Parameters` | hashtable | No | Defaults | Operation parameters |

**Returns:** Object with `estimated_cost`, `currency`, `model`, `breakdown`

**Example:**

```powershell
Invoke-FalEstimateCost -Model "fal-ai/flux-pro" -Parameters @{ steps = 50; width = 2048; height = 2048 }
```

### Invoke-FalPricing

View pricing information for fal.ai models.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Model` | string | No | — | Specific model (omit for all models) |
| `-Category` | string | No | — | Filter by category |

**Returns:** Array of pricing objects with `model`, `price_per_request`, `price_per_second`

**Example:**

```powershell
Invoke-FalPricing -Category "image"
```

### Invoke-FalUsage

Check account usage statistics and remaining limits.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Period` | string | No | `current` | Billing period: `current`, `previous`, or date string |

**Returns:** Object with `total_cost`, `requests`, `period`, `limits`

**Example:**

```powershell
Invoke-FalUsage -Period current
```

---

## Workflow

### New-FalWorkflow

Define a reusable multi-step media workflow.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `-Name` | string | Yes | — | Workflow name |
| `-Steps` | array | Yes | — | Ordered list of step definitions |
| `-Checkpoint` | switch | No | `$false` | Enable checkpointing |
| `-OutputDir` | string | No | `./output` | Directory for workflow outputs |

**Returns:** Workflow definition object

**Example:**

```powershell
$steps = @(
    @{ action = "generate"; prompt = "Product photo"; model = "fal-ai/flux-pro"; seed = 42 },
    @{ action = "upscale"; scale = 2 },
    @{ action = "resize"; width = 1200; height = 1200 }
)

New-FalWorkflow -Name "product-photo" -Steps $steps -Checkpoint
```
