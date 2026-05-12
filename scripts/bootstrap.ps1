# Clarion Demo — Bootstrap (Windows)
$ErrorActionPreference = "Stop"

$DemoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$FixtureDir = Join-Path $DemoRoot "fixtures\demo-app"

Write-Host ""
Write-Host "Clarion Demo - Bootstrap" -ForegroundColor Cyan
Write-Host ""

if ($env:CLARION_BIN) {
    $Clarion = "node `"$env:CLARION_BIN`""
} else {
    $Clarion = "clarion"
}

Write-Host "Using Clarion: $Clarion"
Write-Host "Demo fixture:  $FixtureDir"
Write-Host ""

Set-Location $FixtureDir

Write-Host "-> Initializing Clarion governance..."
Invoke-Expression "$Clarion init --repo ." 2>$null
Write-Host "  Done"

Write-Host "-> Running doctor check..."
Invoke-Expression "$Clarion doctor --repo . --json" 2>$null | Out-Null
Write-Host "  Done"

Write-Host ""
Write-Host "Bootstrap complete. Run .\scripts\run-demo.ps1 to start." -ForegroundColor Green
