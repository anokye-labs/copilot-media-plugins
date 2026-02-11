BeforeAll {
    Import-Module "$PSScriptRoot/../helpers/TestHelper.psm1" -Force
}

Describe 'Invoke-FalGenerate' {
    Context 'When generating an image' {
        It 'Should return image URL on success' -Skip {
            # TODO: Implement after Invoke-FalGenerate.ps1 is created (#16)
        }
    }
}
