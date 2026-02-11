function New-MockFalApiResponse {
    <#
    .SYNOPSIS
        Creates a mock fal.ai API response for testing.
    .PARAMETER ImageUrl
        The URL to use in the mock response.
    .PARAMETER Width
        Image width in pixels.
    .PARAMETER Height
        Image height in pixels.
    .PARAMETER Seed
        The seed value for reproducibility.
    .PARAMETER Prompt
        The prompt used for generation.
    #>
    [CmdletBinding()]
    param(
        [string]$ImageUrl = 'https://fal.ai/output/test.png',
        [int]$Width = 1024,
        [int]$Height = 1024,
        [int]$Seed = 42,
        [string]$Prompt = 'test prompt'
    )

    return [PSCustomObject]@{
        images = @(
            [PSCustomObject]@{
                url    = $ImageUrl
                width  = $Width
                height = $Height
            }
        )
        seed   = $Seed
        prompt = $Prompt
    }
}

function New-MockImageFile {
    <#
    .SYNOPSIS
        Creates a minimal 1x1 pixel PNG file for testing.
    .PARAMETER Path
        The file path to write the test image to.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    # Minimal valid 1x1 pixel white PNG (67 bytes)
    $pngBytes = [byte[]]@(
        0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,  # PNG signature
        0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,  # IHDR chunk
        0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,  # 1x1
        0x08, 0x02, 0x00, 0x00, 0x00, 0x90, 0x77, 0x53,
        0xDE, 0x00, 0x00, 0x00, 0x0C, 0x49, 0x44, 0x41,  # IDAT chunk
        0x54, 0x08, 0xD7, 0x63, 0xF8, 0xCF, 0xC0, 0x00,
        0x00, 0x00, 0x02, 0x00, 0x01, 0xE2, 0x21, 0xBC,
        0x33, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E,  # IEND chunk
        0x44, 0xAE, 0x42, 0x60, 0x82
    )

    $directory = Split-Path -Parent $Path
    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    [System.IO.File]::WriteAllBytes($Path, $pngBytes)
    return (Get-Item $Path)
}

function Assert-FileStructure {
    <#
    .SYNOPSIS
        Validates that expected directories and files exist.
    .PARAMETER BasePath
        The root path to check from.
    .PARAMETER Paths
        Array of relative paths (files or directories) that should exist.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$BasePath,

        [Parameter(Mandatory)]
        [string[]]$Paths
    )

    foreach ($relativePath in $Paths) {
        $fullPath = Join-Path $BasePath $relativePath
        $fullPath | Should -Exist -Because "Expected path '$relativePath' to exist under '$BasePath'"
    }
}

function Get-TestFixturePath {
    <#
    .SYNOPSIS
        Resolves the full path to a test fixture file.
    .PARAMETER FixtureName
        The relative path within the fixtures directory.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$FixtureName
    )

    $fixturesRoot = Join-Path $PSScriptRoot '..' 'fixtures'
    $fullPath = Join-Path $fixturesRoot $FixtureName

    if (-not (Test-Path $fullPath)) {
        throw "Fixture not found: $FixtureName (looked in $fixturesRoot)"
    }

    return (Resolve-Path $fullPath).Path
}

Export-ModuleMember -Function @(
    'New-MockFalApiResponse'
    'New-MockImageFile'
    'Assert-FileStructure'
    'Get-TestFixturePath'
)
