# Clarion Demo — Reset (Windows)
$DemoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$FixtureDir = Join-Path $DemoRoot "fixtures\demo-app"
$PantheonDir = Join-Path $FixtureDir ".pantheon"

if (Test-Path $PantheonDir) {
    Remove-Item -Recurse -Force $PantheonDir
    Write-Host "Removed .pantheon/ state"
} else {
    Write-Host "No state to remove"
}
Write-Host "Run .\scripts\bootstrap.ps1 to start fresh."
